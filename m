Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C6A327CB
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Feb 2025 14:58:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDF4-0003i9-T6; Wed, 12 Feb 2025 08:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tiCTq-0001kR-NE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:08:47 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1tiCTj-0000aw-Bz
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:08:39 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250212130828epoutp015c8a65ac53eb922a420a39bc5fb15e5e~jd_VgXhzF0744607446epoutp01S
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:08:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250212130828epoutp015c8a65ac53eb922a420a39bc5fb15e5e~jd_VgXhzF0744607446epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1739365708;
 bh=aH6hNuq4o8VH6EBItpXBg3NZCF57oQNgUhJfWyllJPA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oDhOOGjrh4aTENQzE8MnauW2Ou79mBSufMriuRD0LtZhxZJh8vjl661tAXpHUrBhW
 GfsfU0zygxTCWPW8YrAjNlldU0OToYOCuRG8LIXQ+f/5/MoMwYxrSkQTa8P0VwTGFs
 jksMMRzXTMXDgKHj6Rpmz371WW9ZK47vDFzMnOjk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20250212130827epcas5p36a40693e0cbf6fd390fbd5198424d7cf~jd_Umigr62814328143epcas5p3G;
 Wed, 12 Feb 2025 13:08:27 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.177]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4YtJXT6DhHz4x9Pp; Wed, 12 Feb
 2025 13:08:25 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 F1.9F.29212.94D9CA76; Wed, 12 Feb 2025 22:08:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20250212113729epcas5p2707be4e4b7787ea8ba5f47f3b31a1ac3~jcu6IVoZ-0329103291epcas5p20;
 Wed, 12 Feb 2025 11:37:29 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20250212113729epsmtrp140ebe53f39b59bf5155180ee7b507848~jcu6HhVtu0509205092epsmtrp16;
 Wed, 12 Feb 2025 11:37:29 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-a3-67ac9d49f09f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 8B.6A.18949.9F78CA76; Wed, 12 Feb 2025 20:37:29 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250212113728epsmtip17255d461eb0e7244d40bf0a694e17c22~jcu4dwqg10939709397epsmtip1a;
 Wed, 12 Feb 2025 11:37:27 +0000 (GMT)
Date: Wed, 12 Feb 2025 17:07:01 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
 krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH 2/3] hw/cxl/cxl-mailbox-utils.c: Added support for Clear
 Log (Opcode 0403h)
Message-ID: <20250212113631.ngye4varkii5bb5j@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <20250204105342.00000c31@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmuq7n3DXpBh9O6VlMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLVwmtsFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfdo+XIW1aP
 J9c2M3n0bVnF6DF1dr3H501yAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
 Sgp5ibmptkouPgG6bpk5QIcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
 E3OLS/PS9fJSS6wMDQyMTIEKE7IzXqzoYypoVar4vPkxUwPjO4kuRk4OCQETiTdXVzJ3MXJx
 CAnsYZS49uALlPOJUeLfks9QzjdGib0Ln7PDtPTe7meFSOxllHizczkLXMvP9s1MIFUsAqoS
 1z8dZwGx2QR0JM7fnssGYosIGEm8uzGJEaSBWeAmo0TjpGdgCWGBRInO4x1gDbwCzhK/zl9h
 g7AFJU7OfAIW5xQwlNh/bR/YNgmBTg6J2bdXskHc5CKx6+VWZghbWOLV8S1Qt0pJvOxvg7Kz
 Jf7Mb4eqL5BY9HMmVNxeovVUP1gvs0CGROvKPUwQcVmJqafWMUHE+SR6fz+BivNK7JgHY6tJ
 tO+YDzVHRuLNr8VQ8z0kjq3/zwgJlg+MEnt2T2acwCg3C8lDs5Dsg7CtJDo/NLHOYuQAsqUl
 lv/jgDA1Jdbv0l/AyLqKUSq1oDg3PTXZtMBQNy+1HB7Ryfm5mxjB6VUrYAfj6g1/9Q4xMnEw
 HmKU4GBWEuGVmLYmXYg3JbGyKrUoP76oNCe1+BCjKTCKJjJLiSbnAxN8Xkm8oYmlgYmZmZmJ
 pbGZoZI4b/POlnQhgfTEktTs1NSC1CKYPiYOTqkGJk9hw/sX/7E6P1dojXWZUPbec1VRS726
 y1H+e+/L7pXl8G1ONj2+SD0kVf6lsNnk41490tPrG/qEuPYlTl33m5s3SydgN287t9jHTxve
 fel0UPY/wsencPPbmti7mu9Sj8/U2jUlZMZRyfP1Iol1Zteimo2zNpV9LJvRytcq6Ha20C9O
 /4jT0teWrsySQpP3CviuC9C9c+MxWzfHAi37LbaP5wpL3tW+sHPnue3qfkFHMyfO2xj9MPy8
 3v8tj339dN7fUhFmbN/zrPnLivOCT9PP5OfrfvJoE46XWxRx2LBq16qtF+ce8+w5LxK97G5R
 gDYH990whpSSgjqrO49YRVQPK67nXT3L/KiqQtcDJZbijERDLeai4kQAW//AbjgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnO7P9jXpBns3GFlMP6xo8eX0HjaL
 1TfXMFrcPLCTyWLVwmtsFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfdo+XIW1aP
 J9c2M3n0bVnF6DF1dr3H501yAWxRXDYpqTmZZalF+nYJXBlfZ1xnLNguX3Hm/AmWBsZdYl2M
 nBwSAiYSvbf7WbsYuTiEBHYzSqzd8pMVIiEjcXHmYxYIW1hi5b/n7BBFHxglHhydzw6SYBFQ
 lbj+6ThYEZuAjsT523PZQGwRASOJdzcmMYI0MAvcZpT4vfseWJGwQKJE5/EOMJtXwFni1/kr
 bHBTW192MEEkBCVOznwCVsQsYCYxb/ND5i5GDiBbWmL5Pw6QMKeAocT+a/tYJjAKzELSMQtJ
 xyyEjgWMzKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJjQktrB+OeVR/0DjEycTAe
 YpTgYFYS4TVZuCJdiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2ampBalFMFkm
 Dk6pBqbEA/OWtB9bum51T6+3gVDV2RM1r541f/xj0OvP8VfcLTti4suzGz9IVXBOsND9+Kg4
 7JrWrPdR+x7zVs3qaC3pL+p+OSfaeLPx5nVhxTrrnuZ8uRH4su743bt9Ia97Itr4VXT6FtuE
 npqrPD33wD+V2w5tHkqpMyLz+JqsVjrqHDgh6vRaL22TQOYVmVrDy6dPs/gEOjheXFM8wTf+
 5D6RdT9fHr/ywfhEk3tZWKtb4qY+0ZmiHTzLctjK+72crBZs8jZ7eV2dUSnteUbNuhs1R148
 WbBxp9fefdG6OybVu/Eq9nx9rflq49PZCQvrXLhOJB1tmz3dqTb2vOODPsGbgd0ba7du6tb/
 cVXT/I8SS3FGoqEWc1FxIgBksDfC+AIAAA==
X-CMS-MailID: 20250212113729epcas5p2707be4e4b7787ea8ba5f47f3b31a1ac3
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----8pCVYZkCOGUjObx0wm0yJlGbi0Dl-Xo5m.-jYkYL.P4N.DQv=_4c48b_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
 <CGME20250203060053epcas5p137fe4cbd5661afdfd2602dbc7facdcb9@epcas5p1.samsung.com>
 <20250203055950.2126627-3-arpit1.kumar@samsung.com>
 <20250204105342.00000c31@huawei.com>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Feb 2025 08:57:28 -0500
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

------8pCVYZkCOGUjObx0wm0yJlGbi0Dl-Xo5m.-jYkYL.P4N.DQv=_4c48b_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 04/02/25 10:53AM, Jonathan Cameron wrote:
>On Mon,  3 Feb 2025 11:29:49 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>Add some description of what is being added here.
>
>Key issue in here is that clearing the CEL doesn't make
>sense. It is a description of what the device supports, there
>is no state to clear in it.  To add this command you need
>to pick a different log.
>
>Jonathan
>
Thanks for the review Jonathan, will modify the code accordingly 
in V2 patch.

>
>> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
>> Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
>> Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
>> ---
>>  hw/cxl/cxl-mailbox-utils.c | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>> index 3d66a425a9..5fd7f850c4 100644
>> --- a/hw/cxl/cxl-mailbox-utils.c
>> +++ b/hw/cxl/cxl-mailbox-utils.c
>> @@ -77,6 +77,7 @@ enum {
>>          #define GET_SUPPORTED 0x0
>>          #define GET_LOG       0x1
>>          #define GET_LOG_CAPABILITIES   0x2
>> +        #define CLEAR_LOG     0x3
>>      FEATURES    = 0x05,
>>          #define GET_SUPPORTED 0x0
>>          #define GET_FEATURE   0x1
>> @@ -1115,6 +1116,39 @@ static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
>>      return CXL_MBOX_SUCCESS;
>>  }
>>
>> +/* CXL r3.1 Section 8.2.9.5.4: Clear Log (Opcode 0403h) */
>> +static CXLRetCode cmd_logs_clear_log(const struct cxl_cmd *cmd,
>> +                                     uint8_t *payload_in,
>> +                                     size_t len_in,
>> +                                     uint8_t *payload_out,
>> +                                     size_t *len_out,
>> +                                     CXLCCI *cci)
>> +{
>> +    int32_t cap_id;
>> +    struct {
>> +        QemuUUID uuid;
>> +    } QEMU_PACKED QEMU_ALIGNED(8) * clear_log = (void *)payload_in;
>> +
>> +    cap_id = valid_log_check(&clear_log->uuid, cci);
>> +    if (cap_id == -1) {
>> +        return CXL_MBOX_INVALID_LOG;
>> +    }
>
>Follow on from previous patch, if this returns the cap pointer,
>the following code wont have to index the array and should end up simpler.
>
okay

>> +
>> +    if (cci->supported_log_cap[cap_id].param_flags.clear_log_supported) {
>I would flip this.
>    if (!(cap->param_flags & PARAM_FLAG_CLEAR_LOG_SUPPORTED)) {
>        return CXL_MBOX_UNSUPPORTED;
>    }
>
>
>> +        switch (cap_id) {
>> +        case CEL:
>
>So if we return the cap as suggested, it will have to reference what it is
>or provide a callback (which might be cleaner as this grows).
>
>However, what does clearly the command effects log mean?
>This makes no sense.  So if you want to implement clear_log you
>need to implement a different log to clear.
>
okay

>> +            memset(cci->cel_log, 0, (1 << 16) * sizeof(struct cel_log));
>> +            cci->cel_size = 0;
>> +            break;
>> +        default:
>> +            return CXL_MBOX_UNSUPPORTED;
>> +        }
>> +    } else {
>> +        return CXL_MBOX_UNSUPPORTED;
>> +    }
>> +    return CXL_MBOX_SUCCESS;
>> +}
>> +
>>  /* CXL r3.1 section 8.2.9.6: Features */
>>  /*
>>   * Get Supported Features output payload
>> @@ -2882,6 +2916,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>>      [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
>>                                       cmd_logs_get_log_capabilities, 0x10, 0 },
>> +    [LOGS][CLEAR_LOG] = { "LOGS_CLEAR_LOG", cmd_logs_clear_log, 0x10,
>> +                          CXL_MBOX_IMMEDIATE_LOG_CHANGE},
>>      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
>>                                    cmd_features_get_supported, 0x8, 0 },
>>      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
>

------8pCVYZkCOGUjObx0wm0yJlGbi0Dl-Xo5m.-jYkYL.P4N.DQv=_4c48b_
Content-Type: text/plain; charset="utf-8"


------8pCVYZkCOGUjObx0wm0yJlGbi0Dl-Xo5m.-jYkYL.P4N.DQv=_4c48b_--

