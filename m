Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE41975896
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 18:36:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQIn-0003FW-4u; Wed, 11 Sep 2024 12:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1soQIl-0003F3-JU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:34:43 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1soQIj-00021S-QG
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:34:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0AF4F219C6;
 Wed, 11 Sep 2024 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726072480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baI3j+yii4Q4jrF2Hp7eJpLnCPfHXMRUDqATcjO+O5A=;
 b=03gs9T+tBBAGQzNJ18DzsgcMA0ASSbVVlufL0X/1AubGBhGXTLfybwLFkrvmWxc16UXTJV
 xhGSei1F6b4yqKJWSRlffMSW2dMRNxhhuylLpITPfukxn//NmHIgc1CEJZLkyYQrnuulZI
 o0RrwshmtFzMysu495KXTqwmT9KzoPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726072480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baI3j+yii4Q4jrF2Hp7eJpLnCPfHXMRUDqATcjO+O5A=;
 b=teRpR1TdYPsWmP1NqAfHpS3Qs/5Gf597p7yx3a6NoSyEv6SFOhzCI3kyulzuDGskc67D0M
 fdTc6bXVjGVbRiAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726072480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baI3j+yii4Q4jrF2Hp7eJpLnCPfHXMRUDqATcjO+O5A=;
 b=03gs9T+tBBAGQzNJ18DzsgcMA0ASSbVVlufL0X/1AubGBhGXTLfybwLFkrvmWxc16UXTJV
 xhGSei1F6b4yqKJWSRlffMSW2dMRNxhhuylLpITPfukxn//NmHIgc1CEJZLkyYQrnuulZI
 o0RrwshmtFzMysu495KXTqwmT9KzoPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726072480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baI3j+yii4Q4jrF2Hp7eJpLnCPfHXMRUDqATcjO+O5A=;
 b=teRpR1TdYPsWmP1NqAfHpS3Qs/5Gf597p7yx3a6NoSyEv6SFOhzCI3kyulzuDGskc67D0M
 fdTc6bXVjGVbRiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C82C213A7C;
 Wed, 11 Sep 2024 16:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +Dw7L5/G4WZHBQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Wed, 11 Sep 2024 16:34:39 +0000
Message-ID: <13967315-4b50-4e66-9e46-02e44d0d6243@suse.de>
Date: Wed, 11 Sep 2024 18:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove unnecessary code in the interface
 accel_system_init_ops_interfaces
From: Claudio Fontana <cfontana@suse.de>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>, philmd@linaro.org,
 alistair.francis@wdc.com, pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20240909031736.1881-1-andrew.yuan@jaguarmicro.com>
 <e93d6ed4-8fe2-434b-9d84-997bae44847f@ventanamicro.com>
 <0cbe47a3-5572-4f74-b2ba-69abd8d3b448@suse.de>
Content-Language: en-US
In-Reply-To: <0cbe47a3-5572-4f74-b2ba-69abd8d3b448@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, gnu.org:url,
 suse.de:email, suse.de:mid]
X-Spam-Score: -4.30
Received-SPF: pass client-ip=195.135.223.130; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/9/24 12:07, Claudio Fontana wrote:
> On 9/9/24 11:54, Daniel Henrique Barboza wrote:
>>
>>
>> On 9/9/24 12:17 AM, Andrew.Yuan wrote:
>>> The code 'ops = ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));' is unnecessary;
>>>
>>> And, the following code :
>>> 1.has the same functionality;
>>> 2.includes error checking;
>>>
>>> Signed-off-by: Andrew.Yuan <andrew.yuan@jaguarmicro.com>
>>> ---
>>>   accel/accel-system.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>>> index f6c947dd82..5d502c8fd8 100644
>>> --- a/accel/accel-system.c
>>> +++ b/accel/accel-system.c
>>> @@ -73,7 +73,7 @@ void accel_system_init_ops_interfaces(AccelClass *ac)
>>>       g_assert(ac_name != NULL);
>>>   
>>>       ops_name = g_strdup_printf("%s" ACCEL_OPS_SUFFIX, ac_name);
>>> -    ops = ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));
>>> +
>>
>> The code you're changing was added by 5141e9a23f ("accel: abort if we fail to
>> load the accelerator plugin") and I think this repetition is intended. If I have
>> to guess (first time looking at this code), ACCEL_OPS_CLASS() is creating the class
>> type QOM functions that the the second module_object_class_by_name() relies on to
>> catch the module load error the commit is trying to address.
>>
>> I'm CCing Claudio to get a better idea of the intention here. At the very least we
>> should add a code comment explaining the reasoning behind initing 'ops' two times
>> in a row and so on.
>>
>>
>> Thanks,
>>
>> Daniel
> 
> Hi Daniel, just to signal that I've seen this message and will get to it when I am back to work later this week.
> 
> Ciao,
> 
> Claudio
> 

Hi all, I think it was my mistake. I already detected it during the PULL request, but my message was missed at the time I think:

https://lists.gnu.org/archive/html/qemu-devel/2022-11/msg01056.html

So

Reviewed-by: Claudio Fontana <cfontana@suse.de>

Thanks,

CLaudio


