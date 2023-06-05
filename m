Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E329A722A89
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6BrJ-00078r-HM; Mon, 05 Jun 2023 11:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hare@suse.de>)
 id 1q6BrF-00078a-4Q; Mon, 05 Jun 2023 11:10:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hare@suse.de>)
 id 1q6BrD-0001o4-7S; Mon, 05 Jun 2023 11:10:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 093941FD6E;
 Mon,  5 Jun 2023 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685977851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=foC6zo/MudKNjp+2ZHYEFwf4xW0BKttOxQywxgADcEU=;
 b=X1AgbqSR5v1OQtDXQeMeh8wN75twRdSQGTdCcnVCMiJiTMNse4HCzg3NCKhrX3smN2rnFo
 fZ+LVsyyY2e2vqshAXVl1O7A+yoh86M5t34Bb10plzmhYodQmnBYSaPzPR/thPzsuexRvw
 tm2u2Qwn2vmGSEHyAFHjftAr5/PjWf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685977851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=foC6zo/MudKNjp+2ZHYEFwf4xW0BKttOxQywxgADcEU=;
 b=Xsg/uxeqWbM4Vep5iCyUPRz3+CFs7kj05xc3dY10zNM+XUWvoaxKS8/BhTmNe4+p1JXmLG
 DEzqGfOsvhMuMBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4A1B139C8;
 Mon,  5 Jun 2023 15:10:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jnyXMvr6fWQKbAAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 05 Jun 2023 15:10:50 +0000
Message-ID: <9f896902-a9a5-97f4-2963-a46e8cefcd08@suse.de>
Date: Mon, 5 Jun 2023 17:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] hw/scsi/megasas: Silent GCC duplicated-cond warning
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Hannes Reinecke <hare@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20230328210126.16282-1-philmd@linaro.org>
 <39574948-bbc1-165e-5f49-20f8a560e732@linaro.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <39574948-bbc1-165e-5f49-20f8a560e732@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=hare@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/5/23 15:44, Philippe Mathieu-Daudé wrote:
> ping?
> 
> On 28/3/23 23:01, Philippe Mathieu-Daudé wrote:
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> GCC9 is confused when building with CFLAG -O3:
>>
>>    hw/scsi/megasas.c: In function ‘megasas_scsi_realize’:
>>    hw/scsi/megasas.c:2387:26: error: duplicated ‘if’ condition 
>> [-Werror=duplicated-cond]
>>     2387 |     } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
>>    hw/scsi/megasas.c:2385:19: note: previously used here
>>     2385 |     if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
>>    cc1: all warnings being treated as errors
>>
>> When this device was introduced in commit e8f943c3bcc, the author
>> cared about modularity, using a definition for the firmware limit.
>>
>> However if the firmware limit isn't changed (MEGASAS_MAX_SGE = 128),
>> the code ends doing the same check twice.
>>
>> Per the maintainer [*]:
>>
>>> The original code assumed that one could change MFI_PASS_FRAME_SIZE,
>>> but it turned out not to be possible as it's being hardcoded in the
>>> drivers themselves (even though the interface provides mechanisms to
>>> query it). So we can remove the duplicate lines.
>>
>> Add the 'MEGASAS_MIN_SGE' definition for the '64' magic value,
>> slightly rewrite the condition check to simplify a bit the logic
>> and remove the unnecessary / duplicated check.
>>
>> [*] 
>> https://lore.kernel.org/qemu-devel/e0029fc5-882f-1d63-15e3-1c3dbe9b6a2c@suse.de/
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> v1: 
>> https://lore.kernel.org/qemu-devel/20191217173425.5082-6-philmd@redhat.com/
>> ---
>>   hw/scsi/megasas.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
>> index 9cbbb16121..32c70c9e99 100644
>> --- a/hw/scsi/megasas.c
>> +++ b/hw/scsi/megasas.c
>> @@ -42,6 +42,7 @@
>>   #define MEGASAS_MAX_FRAMES 2048         /* Firmware limit at 65535 */
>>   #define MEGASAS_DEFAULT_FRAMES 1000     /* Windows requires this */
>>   #define MEGASAS_GEN2_DEFAULT_FRAMES 1008     /* Windows requires 
>> this */
>> +#define MEGASAS_MIN_SGE 64
>>   #define MEGASAS_MAX_SGE 128             /* Firmware limit */
>>   #define MEGASAS_DEFAULT_SGE 80
>>   #define MEGASAS_MAX_SECTORS 0xFFFF      /* No real limit */
>> @@ -2356,6 +2357,7 @@ static void megasas_scsi_realize(PCIDevice *dev, 
>> Error **errp)
>>       MegasasState *s = MEGASAS(dev);
>>       MegasasBaseClass *b = MEGASAS_GET_CLASS(s);
>>       uint8_t *pci_conf;
>> +    uint32_t sge;
>>       int i, bar_type;
>>       Error *err = NULL;
>>       int ret;
>> @@ -2424,13 +2426,15 @@ static void megasas_scsi_realize(PCIDevice 
>> *dev, Error **errp)
>>       if (!s->hba_serial) {
>>           s->hba_serial = g_strdup(MEGASAS_HBA_SERIAL);
>>       }
>> -    if (s->fw_sge >= MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE) {
>> -        s->fw_sge = MEGASAS_MAX_SGE - MFI_PASS_FRAME_SIZE;
>> -    } else if (s->fw_sge >= 128 - MFI_PASS_FRAME_SIZE) {
>> -        s->fw_sge = 128 - MFI_PASS_FRAME_SIZE;
>> -    } else {
>> -        s->fw_sge = 64 - MFI_PASS_FRAME_SIZE;
>> +
>> +    sge = s->fw_sge + MFI_PASS_FRAME_SIZE;
>> +    if (sge < MEGASAS_MIN_SGE) {
>> +        sge = MEGASAS_MIN_SGE;
>> +    } else if (sge >= MEGASAS_MAX_SGE) {
>> +        sge = MEGASAS_MAX_SGE;
>>       }
>> +    s->fw_sge = sge - MFI_PASS_FRAME_SIZE;
>> +
>>       if (s->fw_cmds > MEGASAS_MAX_FRAMES) {
>>           s->fw_cmds = MEGASAS_MAX_FRAMES;
>>       }
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


