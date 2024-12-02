Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7779E0EAC
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Dec 2024 23:10:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIEbi-0003TC-Nn; Mon, 02 Dec 2024 17:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tIEbg-0003T0-KW; Mon, 02 Dec 2024 17:09:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tIEbV-0005ZP-Gx; Mon, 02 Dec 2024 17:09:28 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Eaa7R004951;
 Mon, 2 Dec 2024 22:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=MZn2jAKuQBOlpUSdgfhczYv4N3jCA+
 Hdnzq1e3o11JU=; b=nQeExoC/4HPLTVcegyhdAJSRGPUAQCcg6ShOeo2lxR+43w
 V+FbrO5dshHLHBqKA0IGOIlMNfrcB8gm0v8qheb3BPLQuSGje66LECVVx2Yq2Bsd
 JxVe2jQV/D5JHI7NzoWjyW9ylHgXcR7kkp2id87pNl2TOhzx6twVBru/Fjk0ZIpX
 Uhe02R1ZLPVFxsT+XT80/MPnsIUwmDyzsK/ioUbmLnHPjWkzTzB0SLuUSd4fVqZk
 zaxJAlGYJKUIWGTPFaO5W34GhQlVTdjQyMF7HERS5A68V6sLJKeefRN3jNRZbVZY
 dJBKImwuphOGGWUj/ltqRP6AjcLJaSNQXWxzX40A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgfqrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 22:09:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B2M93Mc026932;
 Mon, 2 Dec 2024 22:09:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgfqr8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 22:09:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2KnGeQ029560;
 Mon, 2 Dec 2024 22:09:02 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ddya453-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Dec 2024 22:09:02 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B2M916C63504686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Dec 2024 22:09:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62A985805A;
 Mon,  2 Dec 2024 22:09:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5EF15805E;
 Mon,  2 Dec 2024 22:09:00 +0000 (GMT)
Received: from [9.10.80.165] (unknown [9.10.80.165])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Dec 2024 22:09:00 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------EHu4zn6ThyenAuD3R2yBuSPK"
Message-ID: <f8f814b9-e35d-423f-8f62-498117a25159@linux.ibm.com>
Date: Mon, 2 Dec 2024 16:08:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] ppc/xive2: Support group-matching when looking for
 target
From: Mike Kowal <kowal@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-4-kowal@linux.ibm.com>
 <D5PTZRBYLRCS.11N2JP4F1R772@gmail.com>
 <27562c7a-7b3f-45dc-8bc6-ae61b0eddb3e@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <27562c7a-7b3f-45dc-8bc6-ae61b0eddb3e@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j44KVG-lD8K1sa-_sRv1SxssaNTaCJHB
X-Proofpoint-GUID: vEMf0l_8J-og5SJMBBsq63wSDoDKHhWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020179
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This is a multi-part message in MIME format.
--------------EHu4zn6ThyenAuD3R2yBuSPK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/21/2024 4:56 PM, Mike Kowal wrote:
>
> On 11/18/2024 9:22 PM, Nicholas Piggin wrote:
>> On Wed Oct 16, 2024 at 7:13 AM AEST, Michael Kowal wrote:
>>> From: Frederic Barrat <fbarrat@linux.ibm.com>
>>>
>>> If an END has the 'i' bit set (ignore), then it targets a group of
>>> VPs. The size of the group depends on the VP index of the target
>>> (first 0 found when looking at the least significant bits of the
>>> index) so a mask is applied on the VP index of a running thread to
>>> know if we have a match.
>>>
>>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>>> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
>>> ---
>>>   include/hw/ppc/xive.h  |  5 +++-
>>>   include/hw/ppc/xive2.h |  1 +
>>>   hw/intc/pnv_xive2.c    | 33 ++++++++++++++-------
>>>   hw/intc/xive.c         | 56 +++++++++++++++++++++++++-----------
>>>   hw/intc/xive2.c        | 65 
>>> ++++++++++++++++++++++++++++++------------
>>>   5 files changed, 114 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>> index 27ef6c1a17..a177b75723 100644
>>> --- a/include/hw/ppc/xive.h
>>> +++ b/include/hw/ppc/xive.h
>>> @@ -424,6 +424,7 @@ void xive_router_end_notify(XiveRouter *xrtr, 
>>> XiveEAS *eas);
>>>   typedef struct XiveTCTXMatch {
>>>       XiveTCTX *tctx;
>>>       uint8_t ring;
>>> +    bool precluded;
>>>   } XiveTCTXMatch;
>>>     #define TYPE_XIVE_PRESENTER "xive-presenter"
>>> @@ -452,7 +453,9 @@ int xive_presenter_tctx_match(XivePresenter 
>>> *xptr, XiveTCTX *tctx,
>>>   bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>>>                              uint8_t nvt_blk, uint32_t nvt_idx,
>>>                              bool cam_ignore, uint8_t priority,
>>> -                           uint32_t logic_serv);
>>> +                           uint32_t logic_serv, bool *precluded);
>>> +
>>> +uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
>>>     /*
>>>    * XIVE Fabric (Interface between Interrupt Controller and Machine)
>>> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
>>> index 5bccf41159..17c31fcb4b 100644
>>> --- a/include/hw/ppc/xive2.h
>>> +++ b/include/hw/ppc/xive2.h
>>> @@ -121,6 +121,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter 
>>> *xptr, XiveTCTX *tctx,
>>>                                  hwaddr offset, unsigned size);
>>>   void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>>>                                hwaddr offset, uint64_t value, 
>>> unsigned size);
>>> +bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t 
>>> priority);
>>>   void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
>>>                               hwaddr offset, uint64_t value, 
>>> unsigned size);
>>>   void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
>>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>>> index 834d32287b..3fb466bb2c 100644
>>> --- a/hw/intc/pnv_xive2.c
>>> +++ b/hw/intc/pnv_xive2.c
>>> @@ -660,21 +660,34 @@ static int pnv_xive2_match_nvt(XivePresenter 
>>> *xptr, uint8_t format,
>>> logic_serv);
>>>               }
>>>   -            /*
>>> -             * Save the context and follow on to catch duplicates,
>>> -             * that we don't support yet.
>>> -             */
>>>               if (ring != -1) {
>>> -                if (match->tctx) {
>>> +                /*
>>> +                 * For VP-specific match, finding more than one is a
>>> +                 * problem. For group notification, it's possible.
>>> +                 */
>>> +                if (!cam_ignore && match->tctx) {
>>>                       qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already 
>>> found a "
>>>                                     "thread context NVT %x/%x\n",
>>>                                     nvt_blk, nvt_idx);
>>> -                    return false;
>>> +                    /* Should set a FIR if we ever model it */
>>> +                    return -1;
>>> +                }
>>> +                /*
>>> +                 * For a group notification, we need to know if the
>>> +                 * match is precluded first by checking the current
>>> +                 * thread priority. If the interrupt can be delivered,
>>> +                 * we always notify the first match (for now).
>>> +                 */
>>> +                if (cam_ignore &&
>>> +                    xive2_tm_irq_precluded(tctx, ring, priority)) {
>>> +                        match->precluded = true;
>>> +                } else {
>>> +                    if (!match->tctx) {
>>> +                        match->ring = ring;
>>> +                        match->tctx = tctx;
>>> +                    }
>>> +                    count++;
>> Multiple matches logic is a bit shoehorned into the match code here.
>>
>> "Return any best match" would be okay, but match->precluded could be set
>> to true for a non-precluded match if a different match was precluded.
>> And for VP directed interrupts, we can get a match from here which
>> *is* precluded, but has precluded = false!
>>
>> It's a bit confusing.
>>
>> typedef struct XiveTCTXMatch {
>>      XiveTCTX *tctx;
>>      uint8_t ring;
>>      bool precluded;
>> } XiveTCTXMatch;
>>
>> What if this was changed to be more clear it doesn't refer to a single
>> tctx? Something like -
>>
>> XiveNVTMatches {
>>      XiveTCTX *best_tctx;
>>      uint8_t best_ring;
>>      int match_count;
>>      int precluded_group_match_count;
>> }
>
>
> I'll have to wrap my head around this one... 😳   If I can not figure 
> it out, I will et back to you.
>
>
>>>                   }
>>> -
>>> -                match->ring = ring;
>>> -                match->tctx = tctx;
>>> -                count++;
>>>               }
>>>           }
>>>       }
>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>> index bacf518fa6..8ffcac4f65 100644
>>> --- a/hw/intc/xive.c
>>> +++ b/hw/intc/xive.c
>>> @@ -1671,6 +1671,16 @@ static uint32_t 
>>> xive_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
>>>       return xive_nvt_cam_line(blk, 1 << 7 | (pir & 0x7f));
>>>   }
>>>   +uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
>>> +{
>>> +    /*
>>> +     * Group size is a power of 2. The position of the first 0
>>> +     * (starting with the least significant bits) in the NVP index
>>> +     * gives the size of the group.
>>> +     */
>>> +    return 1 << (ctz32(~nvp_index) + 1);
>>> +}
>>> +
>>>   static uint8_t xive_get_group_level(uint32_t nvp_index)
>>>   {
>>>       /* FIXME add crowd encoding */
>>> @@ -1743,30 +1753,39 @@ int xive_presenter_tctx_match(XivePresenter 
>>> *xptr, XiveTCTX *tctx,
>>>   /*
>>>    * This is our simple Xive Presenter Engine model. It is merged in 
>>> the
>>>    * Router as it does not require an extra object.
>>> - *
>>> - * It receives notification requests sent by the IVRE to find one
>>> - * matching NVT (or more) dispatched on the processor threads. In case
>>> - * of a single NVT notification, the process is abbreviated and the
>>> - * thread is signaled if a match is found. In case of a logical server
>>> - * notification (bits ignored at the end of the NVT identifier), the
>>> - * IVPE and IVRE select a winning thread using different filters. This
>>> - * involves 2 or 3 exchanges on the PowerBus that the model does not
>>> - * support.
>>> - *
>>> - * The parameters represent what is sent on the PowerBus
>>>    */
>>>   bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
>>>                              uint8_t nvt_blk, uint32_t nvt_idx,
>>>                              bool cam_ignore, uint8_t priority,
>>> -                           uint32_t logic_serv)
>>> +                           uint32_t logic_serv, bool *precluded)
>>>   {
>>>       XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
>>> -    XiveTCTXMatch match = { .tctx = NULL, .ring = 0 };
>>> +    XiveTCTXMatch match = { .tctx = NULL, .ring = 0, .precluded = 
>>> false };
>>>       uint8_t group_level;
>>>       int count;
>>>         /*
>>> -     * Ask the machine to scan the interrupt controllers for a match
>>> +     * Ask the machine to scan the interrupt controllers for a match.
>>> +     *
>>> +     * For VP-specific notification, we expect at most one match and
>>> +     * one call to the presenters is all we need (abbreviated notify
>>> +     * sequence documented by the architecture).
>>> +     *
>>> +     * For VP-group notification, match_nvt() is the equivalent of the
>>> +     * "histogram" and "poll" commands sent to the power bus to the
>>> +     * presenters. 'count' could be more than one, but we always
>>> +     * select the first match for now. 'precluded' tells if (at least)
>>> +     * one thread matches but can't take the interrupt now because
>>> +     * it's running at a more favored priority. We return the
>>> +     * information to the router so that it can take appropriate
>>> +     * actions (backlog, escalation, broadcast, etc...)
>>> +     *
>>> +     * If we were to implement a better way of dispatching the
>>> +     * interrupt in case of multiple matches (instead of the first
>>> +     * match), we would need a heuristic to elect a thread (for
>>> +     * example, the hardware keeps track of an 'age' in the TIMA) and
>>> +     * a new command to the presenters (the equivalent of the "assign"
>>> +     * power bus command in the documented full notify sequence.
>>>        */
>>>       count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
>>>                              priority, logic_serv, &match);
>>> @@ -1779,6 +1798,8 @@ bool xive_presenter_notify(XiveFabric *xfb, 
>>> uint8_t format,
>>>           group_level = cam_ignore ? xive_get_group_level(nvt_idx) : 0;
>>>           trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, 
>>> group_level);
>>>           xive_tctx_pipr_update(match.tctx, match.ring, priority, 
>>> group_level);
>>> +    } else {
>>> +        *precluded = match.precluded;
>>>       }
>>>         return !!count;
>>> @@ -1818,7 +1839,7 @@ void xive_router_end_notify(XiveRouter *xrtr, 
>>> XiveEAS *eas)
>>>       uint8_t nvt_blk;
>>>       uint32_t nvt_idx;
>>>       XiveNVT nvt;
>>> -    bool found;
>>> +    bool found, precluded;
>>>         uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
>>>       uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
>>> @@ -1901,8 +1922,9 @@ void xive_router_end_notify(XiveRouter *xrtr, 
>>> XiveEAS *eas)
>>>       found = xive_presenter_notify(xrtr->xfb, format, nvt_blk, 
>>> nvt_idx,
>>>                             xive_get_field32(END_W7_F0_IGNORE, end.w7),
>>>                             priority,
>>> - xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7));
>>> -
>>> + xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
>>> +                          &precluded);
>>> +    /* we don't support VP-group notification on P9, so precluded 
>>> is not used */
>>>       /* TODO: Auto EOI. */
>>>         if (found) {
>>> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
>>> index db372f4b30..2cb03c758e 100644
>>> --- a/hw/intc/xive2.c
>>> +++ b/hw/intc/xive2.c
>>> @@ -739,6 +739,12 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, 
>>> bool crowd,
>>>      return xrc->write_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
>>>   }
>>>   +static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
>>> +                                uint32_t vp_mask)
>>> +{
>>> +    return (cam1 & vp_mask) == (cam2 & vp_mask);
>>> +}
>>> +
>>>   /*
>>>    * The thread context register words are in big-endian format.
>>>    */
>>> @@ -753,44 +759,50 @@ int xive2_presenter_tctx_match(XivePresenter 
>>> *xptr, XiveTCTX *tctx,
>>>       uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
>>>       uint32_t qw0w2 = xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
>>>   -    /*
>>> -     * TODO (PowerNV): ignore mode. The low order bits of the NVT
>>> -     * identifier are ignored in the "CAM" match.
>>> -     */
>>> +    uint32_t vp_mask = 0xFFFFFFFF;
>>>         if (format == 0) {
>>> -        if (cam_ignore == true) {
>>> -            /*
>>> -             * F=0 & i=1: Logical server notification (bits ignored at
>>> -             * the end of the NVT identifier)
>>> -             */
>>> -            qemu_log_mask(LOG_UNIMP, "XIVE: no support for LS NVT 
>>> %x/%x\n",
>>> -                          nvt_blk, nvt_idx);
>>> -            return -1;
>>> +        /*
>>> +         * i=0: Specific NVT notification
>>> +         * i=1: VP-group notification (bits ignored at the end of the
>>> +         *      NVT identifier)
>>> +         */
>>> +        if (cam_ignore) {
>>> +            vp_mask = ~(xive_get_vpgroup_size(nvt_idx) - 1);
>>>           }
>>>   -        /* F=0 & i=0: Specific NVT notification */
>>> +        /* For VP-group notifications, threads with LGS=0 are 
>>> excluded */
>>>             /* PHYS ring */
>>>           if ((be32_to_cpu(qw3w2) & TM2_QW3W2_VT) &&
>>> -            cam == xive2_tctx_hw_cam_line(xptr, tctx)) {
>>> +            !(cam_ignore && tctx->regs[TM_QW3_HV_PHYS + TM_LGS] == 
>>> 0) &&
>>> +            xive2_vp_match_mask(cam,
>>> +                                xive2_tctx_hw_cam_line(xptr, tctx),
>>> +                                vp_mask)) {
>>>               return TM_QW3_HV_PHYS;
>>>           }
>>>             /* HV POOL ring */
>>>           if ((be32_to_cpu(qw2w2) & TM2_QW2W2_VP) &&
>>> -            cam == xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2)) {
>>> +            !(cam_ignore && tctx->regs[TM_QW2_HV_POOL + TM_LGS] == 
>>> 0) &&
>>> +            xive2_vp_match_mask(cam,
>>> + xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2),
>>> +                                vp_mask)) {
>>>               return TM_QW2_HV_POOL;
>>>           }
>>>             /* OS ring */
>>>           if ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
>>> -            cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) {
>>> +            !(cam_ignore && tctx->regs[TM_QW1_OS + TM_LGS] == 0) &&
>>> +            xive2_vp_match_mask(cam,
>>> + xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2),
>>> +                                vp_mask)) {
>>>               return TM_QW1_OS;
>>>           }
>>>       } else {
>>>           /* F=1 : User level Event-Based Branch (EBB) notification */
>>>   +        /* FIXME: what if cam_ignore and LGS = 0 ? */
>>>           /* USER ring */
>>>           if  ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
>>>                (cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) &&
>>> @@ -802,6 +814,22 @@ int xive2_presenter_tctx_match(XivePresenter 
>>> *xptr, XiveTCTX *tctx,
>>>       return -1;
>>>   }
>>>   +bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t 
>>> priority)
>>> +{
>>> +    uint8_t *regs = &tctx->regs[ring];
>>> +
>>> +    /*
>>> +     * The xive2_presenter_tctx_match() above tells if there's a match
>>> +     * but for VP-group notification, we still need to look at the
>>> +     * priority to know if the thread can take the interrupt now or if
>>> +     * it is precluded.
>>> +     */
>>> +    if (priority < regs[TM_CPPR]) {
>> Should this also test PIPR?
>>
>> I'm not sure about CPPR and PIPR relationship exactly. Does hardware
>> set PIPR for pending IPB interrupts even if they are not < CPPR? Or
>> does it always reflect the presented interrupt
>
>
> I am not sure.  I will dig into the simulation models, and the 
> architecture process flows which they followed, and find out.


According to the TIMA preccess flows and other XIVE2 models, yes, this 
should be PIPR.  This will be included with group 5:

     80 - ppc/xive2: Fix irq preempted by lower priority irq
          e76a18f3ab5530f12855bb57d3d4ebecb4532b86

I could include it here but there are there changes that pre-req the 
change above,  in group4 and group 5.

MAK


>
>
>>
>> Thanks,
>> Nick
--------------EHu4zn6ThyenAuD3R2yBuSPK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/21/2024 4:56 PM, Mike Kowal
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:27562c7a-7b3f-45dc-8bc6-ae61b0eddb3e@linux.ibm.com">
      <br>
      On 11/18/2024 9:22 PM, Nicholas Piggin wrote:
      <br>
      <blockquote type="cite">On Wed Oct 16, 2024 at 7:13 AM AEST,
        Michael Kowal wrote:
        <br>
        <blockquote type="cite">From: Frederic Barrat
          <a class="moz-txt-link-rfc2396E" href="mailto:fbarrat@linux.ibm.com">&lt;fbarrat@linux.ibm.com&gt;</a>
          <br>
          <br>
          If an END has the 'i' bit set (ignore), then it targets a
          group of
          <br>
          VPs. The size of the group depends on the VP index of the
          target
          <br>
          (first 0 found when looking at the least significant bits of
          the
          <br>
          index) so a mask is applied on the VP index of a running
          thread to
          <br>
          know if we have a match.
          <br>
          <br>
          Signed-off-by: Frederic Barrat <a class="moz-txt-link-rfc2396E" href="mailto:fbarrat@linux.ibm.com">&lt;fbarrat@linux.ibm.com&gt;</a>
          <br>
          Signed-off-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>
          <br>
          ---
          <br>
            include/hw/ppc/xive.h  |  5 +++-
          <br>
            include/hw/ppc/xive2.h |  1 +
          <br>
            hw/intc/pnv_xive2.c    | 33 ++++++++++++++-------
          <br>
            hw/intc/xive.c         | 56
          +++++++++++++++++++++++++-----------
          <br>
            hw/intc/xive2.c        | 65
          ++++++++++++++++++++++++++++++------------
          <br>
            5 files changed, 114 insertions(+), 46 deletions(-)
          <br>
          <br>
          diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
          <br>
          index 27ef6c1a17..a177b75723 100644
          <br>
          --- a/include/hw/ppc/xive.h
          <br>
          +++ b/include/hw/ppc/xive.h
          <br>
          @@ -424,6 +424,7 @@ void xive_router_end_notify(XiveRouter
          *xrtr, XiveEAS *eas);
          <br>
            typedef struct XiveTCTXMatch {
          <br>
                XiveTCTX *tctx;
          <br>
                uint8_t ring;
          <br>
          +    bool precluded;
          <br>
            } XiveTCTXMatch;
          <br>
              #define TYPE_XIVE_PRESENTER "xive-presenter"
          <br>
          @@ -452,7 +453,9 @@ int
          xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
          <br>
            bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
          <br>
                                       uint8_t nvt_blk, uint32_t
          nvt_idx,
          <br>
                                       bool cam_ignore, uint8_t
          priority,
          <br>
          -                           uint32_t logic_serv);
          <br>
          +                           uint32_t logic_serv, bool
          *precluded);
          <br>
          +
          <br>
          +uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
          <br>
              /*
          <br>
             * XIVE Fabric (Interface between Interrupt Controller and
          Machine)
          <br>
          diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
          <br>
          index 5bccf41159..17c31fcb4b 100644
          <br>
          --- a/include/hw/ppc/xive2.h
          <br>
          +++ b/include/hw/ppc/xive2.h
          <br>
          @@ -121,6 +121,7 @@ uint64_t
          xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
          <br>
                                           hwaddr offset, unsigned
          size);
          <br>
            void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX
          *tctx,
          <br>
                                         hwaddr offset, uint64_t value,
          unsigned size);
          <br>
          +bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t
          priority);
          <br>
            void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX
          *tctx,
          <br>
                                        hwaddr offset, uint64_t value,
          unsigned size);
          <br>
            void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX
          *tctx,
          <br>
          diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
          <br>
          index 834d32287b..3fb466bb2c 100644
          <br>
          --- a/hw/intc/pnv_xive2.c
          <br>
          +++ b/hw/intc/pnv_xive2.c
          <br>
          @@ -660,21 +660,34 @@ static int
          pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
          <br>
                                                              
          logic_serv);
          <br>
                        }
          <br>
            -            /*
          <br>
          -             * Save the context and follow on to catch
          duplicates,
          <br>
          -             * that we don't support yet.
          <br>
          -             */
          <br>
                        if (ring != -1) {
          <br>
          -                if (match-&gt;tctx) {
          <br>
          +                /*
          <br>
          +                 * For VP-specific match, finding more than
          one is a
          <br>
          +                 * problem. For group notification, it's
          possible.
          <br>
          +                 */
          <br>
          +                if (!cam_ignore &amp;&amp; match-&gt;tctx) {
          <br>
                                qemu_log_mask(LOG_GUEST_ERROR, "XIVE:
          already found a "
          <br>
                                              "thread context NVT
          %x/%x\n",
          <br>
                                              nvt_blk, nvt_idx);
          <br>
          -                    return false;
          <br>
          +                    /* Should set a FIR if we ever model it
          */
          <br>
          +                    return -1;
          <br>
          +                }
          <br>
          +                /*
          <br>
          +                 * For a group notification, we need to know
          if the
          <br>
          +                 * match is precluded first by checking the
          current
          <br>
          +                 * thread priority. If the interrupt can be
          delivered,
          <br>
          +                 * we always notify the first match (for
          now).
          <br>
          +                 */
          <br>
          +                if (cam_ignore &amp;&amp;
          <br>
          +                    xive2_tm_irq_precluded(tctx, ring,
          priority)) {
          <br>
          +                        match-&gt;precluded = true;
          <br>
          +                } else {
          <br>
          +                    if (!match-&gt;tctx) {
          <br>
          +                        match-&gt;ring = ring;
          <br>
          +                        match-&gt;tctx = tctx;
          <br>
          +                    }
          <br>
          +                    count++;
          <br>
        </blockquote>
        Multiple matches logic is a bit shoehorned into the match code
        here.
        <br>
        <br>
        "Return any best match" would be okay, but match-&gt;precluded
        could be set
        <br>
        to true for a non-precluded match if a different match was
        precluded.
        <br>
        And for VP directed interrupts, we can get a match from here
        which
        <br>
        *is* precluded, but has precluded = false!
        <br>
        <br>
        It's a bit confusing.
        <br>
        <br>
        typedef struct XiveTCTXMatch {
        <br>
             XiveTCTX *tctx;
        <br>
             uint8_t ring;
        <br>
             bool precluded;
        <br>
        } XiveTCTXMatch;
        <br>
        <br>
        What if this was changed to be more clear it doesn't refer to a
        single
        <br>
        tctx? Something like -
        <br>
        <br>
        XiveNVTMatches {
        <br>
             XiveTCTX *best_tctx;
        <br>
             uint8_t best_ring;
        <br>
             int match_count;
        <br>
             int precluded_group_match_count;
        <br>
        }
        <br>
      </blockquote>
      <br>
      <br>
      I'll have to wrap my head around this one... 😳   If I can not
      figure it out, I will et back to you.
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">                  }
          <br>
          -
          <br>
          -                match-&gt;ring = ring;
          <br>
          -                match-&gt;tctx = tctx;
          <br>
          -                count++;
          <br>
                        }
          <br>
                    }
          <br>
                }
          <br>
          diff --git a/hw/intc/xive.c b/hw/intc/xive.c
          <br>
          index bacf518fa6..8ffcac4f65 100644
          <br>
          --- a/hw/intc/xive.c
          <br>
          +++ b/hw/intc/xive.c
          <br>
          @@ -1671,6 +1671,16 @@ static uint32_t
          xive_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
          <br>
                return xive_nvt_cam_line(blk, 1 &lt;&lt; 7 | (pir &amp;
          0x7f));
          <br>
            }
          <br>
            +uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
          <br>
          +{
          <br>
          +    /*
          <br>
          +     * Group size is a power of 2. The position of the first
          0
          <br>
          +     * (starting with the least significant bits) in the NVP
          index
          <br>
          +     * gives the size of the group.
          <br>
          +     */
          <br>
          +    return 1 &lt;&lt; (ctz32(~nvp_index) + 1);
          <br>
          +}
          <br>
          +
          <br>
            static uint8_t xive_get_group_level(uint32_t nvp_index)
          <br>
            {
          <br>
                /* FIXME add crowd encoding */
          <br>
          @@ -1743,30 +1753,39 @@ int
          xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
          <br>
            /*
          <br>
             * This is our simple Xive Presenter Engine model. It is
          merged in the
          <br>
             * Router as it does not require an extra object.
          <br>
          - *
          <br>
          - * It receives notification requests sent by the IVRE to find
          one
          <br>
          - * matching NVT (or more) dispatched on the processor
          threads. In case
          <br>
          - * of a single NVT notification, the process is abbreviated
          and the
          <br>
          - * thread is signaled if a match is found. In case of a
          logical server
          <br>
          - * notification (bits ignored at the end of the NVT
          identifier), the
          <br>
          - * IVPE and IVRE select a winning thread using different
          filters. This
          <br>
          - * involves 2 or 3 exchanges on the PowerBus that the model
          does not
          <br>
          - * support.
          <br>
          - *
          <br>
          - * The parameters represent what is sent on the PowerBus
          <br>
             */
          <br>
            bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
          <br>
                                       uint8_t nvt_blk, uint32_t
          nvt_idx,
          <br>
                                       bool cam_ignore, uint8_t
          priority,
          <br>
          -                           uint32_t logic_serv)
          <br>
          +                           uint32_t logic_serv, bool
          *precluded)
          <br>
            {
          <br>
                XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
          <br>
          -    XiveTCTXMatch match = { .tctx = NULL, .ring = 0 };
          <br>
          +    XiveTCTXMatch match = { .tctx = NULL, .ring = 0,
          .precluded = false };
          <br>
                uint8_t group_level;
          <br>
                int count;
          <br>
                  /*
          <br>
          -     * Ask the machine to scan the interrupt controllers for
          a match
          <br>
          +     * Ask the machine to scan the interrupt controllers for
          a match.
          <br>
          +     *
          <br>
          +     * For VP-specific notification, we expect at most one
          match and
          <br>
          +     * one call to the presenters is all we need (abbreviated
          notify
          <br>
          +     * sequence documented by the architecture).
          <br>
          +     *
          <br>
          +     * For VP-group notification, match_nvt() is the
          equivalent of the
          <br>
          +     * "histogram" and "poll" commands sent to the power bus
          to the
          <br>
          +     * presenters. 'count' could be more than one, but we
          always
          <br>
          +     * select the first match for now. 'precluded' tells if
          (at least)
          <br>
          +     * one thread matches but can't take the interrupt now
          because
          <br>
          +     * it's running at a more favored priority. We return the
          <br>
          +     * information to the router so that it can take
          appropriate
          <br>
          +     * actions (backlog, escalation, broadcast, etc...)
          <br>
          +     *
          <br>
          +     * If we were to implement a better way of dispatching
          the
          <br>
          +     * interrupt in case of multiple matches (instead of the
          first
          <br>
          +     * match), we would need a heuristic to elect a thread
          (for
          <br>
          +     * example, the hardware keeps track of an 'age' in the
          TIMA) and
          <br>
          +     * a new command to the presenters (the equivalent of the
          "assign"
          <br>
          +     * power bus command in the documented full notify
          sequence.
          <br>
                 */
          <br>
                count = xfc-&gt;match_nvt(xfb, format, nvt_blk, nvt_idx,
          cam_ignore,
          <br>
                                       priority, logic_serv,
          &amp;match);
          <br>
          @@ -1779,6 +1798,8 @@ bool xive_presenter_notify(XiveFabric
          *xfb, uint8_t format,
          <br>
                    group_level = cam_ignore ?
          xive_get_group_level(nvt_idx) : 0;
          <br>
                    trace_xive_presenter_notify(nvt_blk, nvt_idx,
          match.ring, group_level);
          <br>
                    xive_tctx_pipr_update(match.tctx, match.ring,
          priority, group_level);
          <br>
          +    } else {
          <br>
          +        *precluded = match.precluded;
          <br>
                }
          <br>
                  return !!count;
          <br>
          @@ -1818,7 +1839,7 @@ void xive_router_end_notify(XiveRouter
          *xrtr, XiveEAS *eas)
          <br>
                uint8_t nvt_blk;
          <br>
                uint32_t nvt_idx;
          <br>
                XiveNVT nvt;
          <br>
          -    bool found;
          <br>
          +    bool found, precluded;
          <br>
                  uint8_t end_blk = xive_get_field64(EAS_END_BLOCK,
          eas-&gt;w);
          <br>
                uint32_t end_idx = xive_get_field64(EAS_END_INDEX,
          eas-&gt;w);
          <br>
          @@ -1901,8 +1922,9 @@ void xive_router_end_notify(XiveRouter
          *xrtr, XiveEAS *eas)
          <br>
                found = xive_presenter_notify(xrtr-&gt;xfb, format,
          nvt_blk, nvt_idx,
          <br>
                                      xive_get_field32(END_W7_F0_IGNORE,
          end.w7),
          <br>
                                      priority,
          <br>
          -                         
          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7));
          <br>
          -
          <br>
          +                         
          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
          <br>
          +                          &amp;precluded);
          <br>
          +    /* we don't support VP-group notification on P9, so
          precluded is not used */
          <br>
                /* TODO: Auto EOI. */
          <br>
                  if (found) {
          <br>
          diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
          <br>
          index db372f4b30..2cb03c758e 100644
          <br>
          --- a/hw/intc/xive2.c
          <br>
          +++ b/hw/intc/xive2.c
          <br>
          @@ -739,6 +739,12 @@ int xive2_router_write_nvgc(Xive2Router
          *xrtr, bool crowd,
          <br>
               return xrc-&gt;write_nvgc(xrtr, crowd, nvgc_blk,
          nvgc_idx, nvgc);
          <br>
            }
          <br>
            +static bool xive2_vp_match_mask(uint32_t cam1, uint32_t
          cam2,
          <br>
          +                                uint32_t vp_mask)
          <br>
          +{
          <br>
          +    return (cam1 &amp; vp_mask) == (cam2 &amp; vp_mask);
          <br>
          +}
          <br>
          +
          <br>
            /*
          <br>
             * The thread context register words are in big-endian
          format.
          <br>
             */
          <br>
          @@ -753,44 +759,50 @@ int
          xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX
          *tctx,
          <br>
                uint32_t qw1w2 =
          xive_tctx_word2(&amp;tctx-&gt;regs[TM_QW1_OS]);
          <br>
                uint32_t qw0w2 =
          xive_tctx_word2(&amp;tctx-&gt;regs[TM_QW0_USER]);
          <br>
            -    /*
          <br>
          -     * TODO (PowerNV): ignore mode. The low order bits of the
          NVT
          <br>
          -     * identifier are ignored in the "CAM" match.
          <br>
          -     */
          <br>
          +    uint32_t vp_mask = 0xFFFFFFFF;
          <br>
                  if (format == 0) {
          <br>
          -        if (cam_ignore == true) {
          <br>
          -            /*
          <br>
          -             * F=0 &amp; i=1: Logical server notification
          (bits ignored at
          <br>
          -             * the end of the NVT identifier)
          <br>
          -             */
          <br>
          -            qemu_log_mask(LOG_UNIMP, "XIVE: no support for LS
          NVT %x/%x\n",
          <br>
          -                          nvt_blk, nvt_idx);
          <br>
          -            return -1;
          <br>
          +        /*
          <br>
          +         * i=0: Specific NVT notification
          <br>
          +         * i=1: VP-group notification (bits ignored at the
          end of the
          <br>
          +         *      NVT identifier)
          <br>
          +         */
          <br>
          +        if (cam_ignore) {
          <br>
          +            vp_mask = ~(xive_get_vpgroup_size(nvt_idx) - 1);
          <br>
                    }
          <br>
            -        /* F=0 &amp; i=0: Specific NVT notification */
          <br>
          +        /* For VP-group notifications, threads with LGS=0 are
          excluded */
          <br>
                      /* PHYS ring */
          <br>
                    if ((be32_to_cpu(qw3w2) &amp; TM2_QW3W2_VT)
          &amp;&amp;
          <br>
          -            cam == xive2_tctx_hw_cam_line(xptr, tctx)) {
          <br>
          +            !(cam_ignore &amp;&amp;
          tctx-&gt;regs[TM_QW3_HV_PHYS + TM_LGS] == 0) &amp;&amp;
          <br>
          +            xive2_vp_match_mask(cam,
          <br>
          +                                xive2_tctx_hw_cam_line(xptr,
          tctx),
          <br>
          +                                vp_mask)) {
          <br>
                        return TM_QW3_HV_PHYS;
          <br>
                    }
          <br>
                      /* HV POOL ring */
          <br>
                    if ((be32_to_cpu(qw2w2) &amp; TM2_QW2W2_VP)
          &amp;&amp;
          <br>
          -            cam == xive_get_field32(TM2_QW2W2_POOL_CAM,
          qw2w2)) {
          <br>
          +            !(cam_ignore &amp;&amp;
          tctx-&gt;regs[TM_QW2_HV_POOL + TM_LGS] == 0) &amp;&amp;
          <br>
          +            xive2_vp_match_mask(cam,
          <br>
          +                               
          xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2),
          <br>
          +                                vp_mask)) {
          <br>
                        return TM_QW2_HV_POOL;
          <br>
                    }
          <br>
                      /* OS ring */
          <br>
                    if ((be32_to_cpu(qw1w2) &amp; TM2_QW1W2_VO)
          &amp;&amp;
          <br>
          -            cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2))
          {
          <br>
          +            !(cam_ignore &amp;&amp; tctx-&gt;regs[TM_QW1_OS +
          TM_LGS] == 0) &amp;&amp;
          <br>
          +            xive2_vp_match_mask(cam,
          <br>
          +                               
          xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2),
          <br>
          +                                vp_mask)) {
          <br>
                        return TM_QW1_OS;
          <br>
                    }
          <br>
                } else {
          <br>
                    /* F=1 : User level Event-Based Branch (EBB)
          notification */
          <br>
            +        /* FIXME: what if cam_ignore and LGS = 0 ? */
          <br>
                    /* USER ring */
          <br>
                    if  ((be32_to_cpu(qw1w2) &amp; TM2_QW1W2_VO)
          &amp;&amp;
          <br>
                         (cam == xive_get_field32(TM2_QW1W2_OS_CAM,
          qw1w2)) &amp;&amp;
          <br>
          @@ -802,6 +814,22 @@ int
          xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX
          *tctx,
          <br>
                return -1;
          <br>
            }
          <br>
            +bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring,
          uint8_t priority)
          <br>
          +{
          <br>
          +    uint8_t *regs = &amp;tctx-&gt;regs[ring];
          <br>
          +
          <br>
          +    /*
          <br>
          +     * The xive2_presenter_tctx_match() above tells if
          there's a match
          <br>
          +     * but for VP-group notification, we still need to look
          at the
          <br>
          +     * priority to know if the thread can take the interrupt
          now or if
          <br>
          +     * it is precluded.
          <br>
          +     */
          <br>
          +    if (priority &lt; regs[TM_CPPR]) {
          <br>
        </blockquote>
        Should this also test PIPR?
        <br>
        <br>
        I'm not sure about CPPR and PIPR relationship exactly. Does
        hardware
        <br>
        set PIPR for pending IPB interrupts even if they are not &lt;
        CPPR? Or
        <br>
        does it always reflect the presented interrupt
        <br>
      </blockquote>
      <br>
      <br>
      I am not sure.  I will dig into the simulation models, and the
      architecture process flows which they followed, and find out.
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>According to the TIMA preccess flows and other XIVE2 models, yes,
      this should be PIPR.  This will be included with group 5:<br>
    </p>
    <div
style="font-family: &quot;Consolas&quot;; font-size: 11.0pt; color: #000000;background-color: #FFFFFF; font-style: normal; font-weight: normal; text-decoration: none;">
      <pre>    80 - ppc/xive2: Fix irq preempted by lower priority irq
         e76a18f3ab5530f12855bb57d3d4ebecb4532b86
</pre>
    </div>
    <p>I could include it here but there are there changes that pre-req
      the change above,  in group4 and group 5.</p>
    <p>MAK  <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:27562c7a-7b3f-45dc-8bc6-ae61b0eddb3e@linux.ibm.com">
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Thanks,
        <br>
        Nick
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------EHu4zn6ThyenAuD3R2yBuSPK--


