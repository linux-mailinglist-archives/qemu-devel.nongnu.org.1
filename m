Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBCDB182A7
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 15:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhq2n-0001A5-Go; Fri, 01 Aug 2025 09:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uhptZ-0000z0-Qq; Fri, 01 Aug 2025 09:34:02 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uhptW-0000K5-3Y; Fri, 01 Aug 2025 09:34:01 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 571DXYEc042719
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 1 Aug 2025 22:33:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=nn3WpyHHP/ItitMTRKxkbfWsO8hyuIyw4WfQhXJ83Bw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754055214; v=1;
 b=SLzkO6cd2LBAtIXu5meJvUs4HfYI/0l3VBppgf5XviQElafo3RcFQjUNd6Wia6u1
 7c1KFZhkQcgacLc1mYQ+2+DFzMfLdMmgNQMH+XXH7kuRU2k5k4zJkXcyCRk8xsR8
 nVAoOslcP2T9Sv99lXYhllYFJTCUZVyBPlx23Kr/kXfA/cZx/M0xe+EoKy6stDxw
 6/AKJ3g7+jkrOpBEdKlKx/WoEklauUBpDgmB5upmVJ18clPaaaNF5qq3viywdtLP
 iPydBAEYiEs/rgY99tTU24DNhiraH1Zay+8SRoFsBHzxRu+BC1t6KmUtNJoJffYh
 SfsAqeJOTp8SxH8siGlfzQ==
Message-ID: <822162a2-c80e-47ae-ba4e-26beb7241216@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 1 Aug 2025 22:33:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/27] migration: push Error **errp into
 qemu_loadvm_section_start_full()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
 <20250731-propagate_tpm_error-v8-5-28fd82fdfdb2@redhat.com>
 <75e91cbc-9116-4265-af47-ce72e87fb2cd@rsg.ci.i.u-tokyo.ac.jp>
 <aIzA2aIUwXKKGNqR@armenon-kvm.bengluru.csb>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aIzA2aIUwXKKGNqR@armenon-kvm.bengluru.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/01 22:27, Arun Menon wrote:
> Hi Akihiko,
> 
> Thanks for the review.
> 
> On Fri, Aug 01, 2025 at 04:12:34PM +0900, Akihiko Odaki wrote:
>> On 2025/07/31 22:20, Arun Menon wrote:
>>> This is an incremental step in converting vmstate loading
>>> code to report error via Error objects instead of directly
>>> printing it to console/monitor.
>>> It is ensured that qemu_loadvm_section_start_full() must report an error
>>> in errp, in case of failure.
>>>
>>> Signed-off-by: Arun Menon <armenon@redhat.com>
>>> ---
>>>    migration/savevm.c | 36 ++++++++++++++++++++----------------
>>>    1 file changed, 20 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>> index 736410be867a29efa24d749528c9bc203a3e8131..59751677c1bb7c893b4ba61cbfe1f55ade6ad598 100644
>>> --- a/migration/savevm.c
>>> +++ b/migration/savevm.c
>>> @@ -2690,8 +2690,9 @@ static bool check_section_footer(QEMUFile *f, SaveStateEntry *se)
>>>    }
>>>    static int
>>> -qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
>>> +qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
>>>    {
>>> +    ERRP_GUARD();
>>>        bool trace_downtime = (type == QEMU_VM_SECTION_FULL);
>>>        uint32_t instance_id, version_id, section_id;
>>>        int64_t start_ts, end_ts;
>>> @@ -2702,8 +2703,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
>>>        /* Read section start */
>>>        section_id = qemu_get_be32(f);
>>>        if (!qemu_get_counted_string(f, idstr)) {
>>> -        error_report("Unable to read ID string for section %u",
>>> -                     section_id);
>>> +        error_setg(errp, "Unable to read ID string for section %u",
>>> +                   section_id);
>>>            return -EINVAL;
>>>        }
>>>        instance_id = qemu_get_be32(f);
>>> @@ -2711,8 +2712,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
>>>        ret = qemu_file_get_error(f);
>>>        if (ret) {
>>> -        error_report("%s: Failed to read instance/version ID: %d",
>>> -                     __func__, ret);
>>> +        error_setg(errp, "Failed to read instance/version ID: %d", ret);
>>>            return ret;
>>>        }
>>> @@ -2721,17 +2721,17 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
>>>        /* Find savevm section */
>>>        se = find_se(idstr, instance_id);
>>>        if (se == NULL) {
>>> -        error_report("Unknown savevm section or instance '%s' %"PRIu32". "
>>> -                     "Make sure that your current VM setup matches your "
>>> -                     "saved VM setup, including any hotplugged devices",
>>> -                     idstr, instance_id);
>>> +        error_setg(errp, "Unknown savevm section or instance '%s' %"PRIu32". "
>>> +                   "Make sure that your current VM setup matches your "
>>> +                   "saved VM setup, including any hotplugged devices",
>>> +                   idstr, instance_id);
>>>            return -EINVAL;
>>>        }
>>>        /* Validate version */
>>>        if (version_id > se->version_id) {
>>> -        error_report("savevm: unsupported version %d for '%s' v%d",
>>> -                     version_id, idstr, se->version_id);
>>> +        error_setg(errp, "savevm: unsupported version %d for '%s' v%d",
>>> +                   version_id, idstr, se->version_id);
>>>            return -EINVAL;
>>>        }
>>>        se->load_version_id = version_id;
>>> @@ -2739,7 +2739,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
>>>        /* Validate if it is a device's state */
>>>        if (xen_enabled() && se->is_ram) {
>>> -        error_report("loadvm: %s RAM loading not allowed on Xen", idstr);
>>> +        error_setg(errp, "loadvm: %s RAM loading not allowed on Xen", idstr);
>>>            return -EINVAL;
>>>        }
>>> @@ -2747,10 +2747,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
>>>            start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>>>        }
>>> -    ret = vmstate_load(f, se, NULL);
>>> +    ret = vmstate_load(f, se, errp);
>>>        if (ret < 0) {
>>> -        error_report("error while loading state for instance 0x%"PRIx32" of"
>>> -                     " device '%s'", instance_id, idstr);
>>> +        error_prepend(errp,
>>> +                      "error while loading state for instance 0x%"PRIx32" of"
>>> +                      " device '%s': ", instance_id, idstr);
>>>            return ret;
>>>        }
>>> @@ -2761,6 +2762,9 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
>>>        }
>>>        if (!check_section_footer(f, se)) {
>>> +        error_setg(errp, "Reading footer section of instance "
>>> +                   "0x%"PRIx32" of device '%s' for version_id:'%d' failed",
>>> +                   instance_id, idstr, version_id);
>>>            return -EINVAL;
>>>        }
>>> @@ -3063,7 +3067,7 @@ retry:
>>>            switch (section_type) {
>>>            case QEMU_VM_SECTION_START:
>>>            case QEMU_VM_SECTION_FULL:
>>> -            ret = qemu_loadvm_section_start_full(f, section_type);
>>> +            ret = qemu_loadvm_section_start_full(f, section_type, NULL);
>>
>> The converted error_report() calls are temporarily dismissed. This can be
>> fixed by moving "[PATCH v8 19/27] migration: push Error **errp into
>> qemu_loadvm_state_main()" and changes for its caller earlier than this.
>>
>> qemu_loadvm_state_main() can have some code to fill errp until all the
>> functions its calls get converted. It will not make the patch bigger thanks
>> to the unified error handling path with "goto out" and the removal of code
>> changes to replace NULL with errp.
> 
> I see your point.
> There is a cyclic dependency between few functions.
> For example, qemu_loadvm_state_main() calls -> loadvm_process_command()
> 				      calls -> loadvm_handle_cmd_packaged()
> 				      calls -> qemu_loadvm_state_main()
> That is why I passed NULL temporarily and then change that in the subsequent
> patches. However, I see that this will cause problems for reviewing and bisection.
> I can introduce a local_err in the caller, and when errp is available, I can pass that.
> That way I will be reporting local_err after it returns. That way the individual
> patches will report the error.

It is not necessary to introduce "local_err"; ERRP_GUARD() is added in 
"[PATCH v8 19/27] migration: push Error **errp into 
qemu_loadvm_state_main()" so you can check if *errp == NULL. This 
hopefully break the cycle dependency without making patches bigger.

Regards,
Akihiko Odaki

