Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2719ED937
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Dec 2024 23:02:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLUlK-0008EX-0X; Wed, 11 Dec 2024 17:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tLUl5-0008E1-RW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:00:40 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tLUkv-0000W8-VG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:00:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:5829:0:640:f281:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5FC6F61586;
 Thu, 12 Dec 2024 01:00:19 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a428::1:17] (unknown
 [2a02:6b8:b081:a428::1:17])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id H0wRlQ4Gi4Y0-gxCoqnFS; Thu, 12 Dec 2024 01:00:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733954418;
 bh=3H5Ul5dOHLbxeJmOUu+im8VoWdwMdnQzGIejpFLPN7M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EZ9bVsLhWqkI3+wrl4+61qX1xmr34VvCwTOipp3DkU4lMRQZ3tjaboinv4+8fdD55
 RmHi9KkhoSgE5lXRyh7ng0Gp1vGcSxyjF5umwYnXFdjx55jvDhil211RpIxI9MStoi
 pDyC/Xyk5P4MoTVcIih+M++g0Eot69u/ooMaR2KA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <39eca0fb-0464-4005-b126-1985c8acb84c@yandex-team.ru>
Date: Thu, 12 Dec 2024 01:00:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] overcommit: introduce mem-lock=on-fault
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20241211000447.1310181-1-d-tatianin@yandex-team.ru>
 <20241211000447.1310181-3-d-tatianin@yandex-team.ru> <Z1oJoIa_JGc6WgC9@x1n>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <Z1oJoIa_JGc6WgC9@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12/12/24 12:52 AM, Peter Xu wrote:

> On Wed, Dec 11, 2024 at 03:04:47AM +0300, Daniil Tatianin wrote:
>> Locking the memory without MCL_ONFAULT instantly prefaults any mmaped
>> anonymous memory with a write-fault, which introduces a lot of extra
>> overhead in terms of memory usage when all you want to do is to prevent
>> kcompactd from migrating and compacting QEMU pages. Add an option to
>> only lock pages lazily as they're faulted by the process by using
>> MCL_ONFAULT if asked.
> Looks good but some nitpicks below..
>
>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>> ---
>>   include/sysemu/sysemu.h  |  1 +
>>   migration/postcopy-ram.c |  4 ++--
>>   qemu-options.hx          | 14 +++++++-----
>>   system/globals.c         |  1 +
>>   system/vl.c              | 46 ++++++++++++++++++++++++++++++++--------
>>   5 files changed, 50 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>> index 7ec419ce13..b6519c3c1e 100644
>> --- a/include/sysemu/sysemu.h
>> +++ b/include/sysemu/sysemu.h
>> @@ -44,6 +44,7 @@ extern const char *keyboard_layout;
>>   extern int old_param;
>>   extern uint8_t *boot_splash_filedata;
>>   extern bool enable_mlock;
>> +extern bool enable_mlock_onfault;
>>   extern bool enable_cpu_pm;
>>   extern QEMUClockType rtc_clock;
>>   
>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index 36ec6a3d75..8ff8c73a27 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -651,8 +651,8 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>>           mis->have_fault_thread = false;
>>       }
>>   
>> -    if (enable_mlock) {
>> -        if (os_mlock(false) < 0) {
>> +    if (enable_mlock || enable_mlock_onfault) {
>> +        if (os_mlock(enable_mlock_onfault) < 0) {
>>               error_report("mlock: %s", strerror(errno));
>>               /*
>>                * It doesn't feel right to fail at this point, we have a valid
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index dacc9790a4..6c8360e62e 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4566,21 +4566,25 @@ SRST
>>   ERST
>>   
>>   DEF("overcommit", HAS_ARG, QEMU_OPTION_overcommit,
>> -    "-overcommit [mem-lock=on|off][cpu-pm=on|off]\n"
>> +    "-overcommit [mem-lock=on|off|on-fault][cpu-pm=on|off]\n"
>>       "                run qemu with overcommit hints\n"
>> -    "                mem-lock=on|off controls memory lock support (default: off)\n"
>> +    "                mem-lock=on|off|on-fault controls memory lock support (default: off)\n"
>>       "                cpu-pm=on|off controls cpu power management (default: off)\n",
>>       QEMU_ARCH_ALL)
>>   SRST
>> -``-overcommit mem-lock=on|off``
>> +``-overcommit mem-lock=on|off|on-fault``
>>     \
>>   ``-overcommit cpu-pm=on|off``
>>       Run qemu with hints about host resource overcommit. The default is
>>       to assume that host overcommits all resources.
>>   
>>       Locking qemu and guest memory can be enabled via ``mem-lock=on``
>> -    (disabled by default). This works when host memory is not
>> -    overcommitted and reduces the worst-case latency for guest.
>> +    or ``mem-lock=on-fault`` (disabled by default). This works when
>> +    host memory is not overcommitted and reduces the worst-case latency for
>> +    guest. The on-fault option is better for reducing the memory footprint
>> +    since it makes allocations lazy, but the pages still get locked in place
>> +    once faulted by the guest or QEMU. Note that the two options are mutually
>> +    exclusive.
>>   
>>       Guest ability to manage power state of host cpus (increasing latency
>>       for other processes on the same host cpu, but decreasing latency for
>> diff --git a/system/globals.c b/system/globals.c
>> index 84ce943ac9..43501fe690 100644
>> --- a/system/globals.c
>> +++ b/system/globals.c
>> @@ -35,6 +35,7 @@ enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
>>   int display_opengl;
>>   const char* keyboard_layout;
>>   bool enable_mlock;
>> +bool enable_mlock_onfault;
>>   bool enable_cpu_pm;
>>   int autostart = 1;
>>   int vga_interface_type = VGA_NONE;
>> diff --git a/system/vl.c b/system/vl.c
>> index 03819a80ef..4e2efd3ad4 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -347,7 +347,7 @@ static QemuOptsList qemu_overcommit_opts = {
>>       .desc = {
>>           {
>>               .name = "mem-lock",
>> -            .type = QEMU_OPT_BOOL,
>> +            .type = QEMU_OPT_STRING,
>>           },
>>           {
>>               .name = "cpu-pm",
>> @@ -792,8 +792,8 @@ static QemuOptsList qemu_run_with_opts = {
>>   
>>   static void realtime_init(void)
>>   {
>> -    if (enable_mlock) {
>> -        if (os_mlock(false) < 0) {
>> +    if (enable_mlock || enable_mlock_onfault) {
> IIUC it's still cleaner to make enable_mlock into an enum to be a
> tri-state.  IOW, we could have two flags set now with the current patch
> when with things like:
>
>    -overcommit mem-lock=on -overcommit mem-lock=on-fault

Oh yeah good catch, that's a problem.

>> +        if (os_mlock(enable_mlock_onfault) < 0) {
>>               error_report("locking memory failed");
>>               exit(1);
>>           }
>> @@ -3532,14 +3532,42 @@ void qemu_init(int argc, char **argv)
>>                   object_option_parse(optarg);
>>                   break;
>>               case QEMU_OPTION_overcommit:
>> -                opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
>> -                                               optarg, false);
>> -                if (!opts) {
>> +                {
>> +                    const char *mem_lock_opt;
>> +
>> +                    opts = qemu_opts_parse_noisily(qemu_find_opts("overcommit"),
>> +                                                   optarg, false);
>> +                    if (!opts) {
>> +                        exit(1);
>> +                    }
>> +
>> +                    enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
>> +
>> +                    mem_lock_opt = qemu_opt_get(opts, "mem-lock");
>> +                    if (!mem_lock_opt) {
>> +                        break;
>> +                    }
>> +
>> +                    if (strcmp(mem_lock_opt, "on") == 0) {
>> +                        enable_mlock = true;
>> +                        break;
>> +                    }
>> +
>> +                    if (strcmp(mem_lock_opt, "off") == 0) {
>> +                        enable_mlock = false;
>> +                        enable_mlock_onfault = false;
>> +                        break;
>> +                    }
>> +
>> +                    if (strcmp(mem_lock_opt, "on-fault") == 0) {
>> +                        enable_mlock_onfault = true;
>> +                        break;
>> +                    }
>> +
>> +                    error_report("parameter 'mem-lock' expects one of "
>> +                                 "'on', 'off', 'on-fault'");
> Not the only one that open code this.. but still there're better references
> like net_client_parse() or monitor_parse() that we could follow.  So would
> be good to put it into a function.
>
> Thanks,

Yeah I'm not a fan of this solution to parsing, but I wasn't able to 
find better examples straight away so went with this. Will take a look 
at the places you've mentioned.

Thanks!

>
>>                       exit(1);
>>                   }
>> -                enable_mlock = qemu_opt_get_bool(opts, "mem-lock", enable_mlock);
>> -                enable_cpu_pm = qemu_opt_get_bool(opts, "cpu-pm", enable_cpu_pm);
>> -                break;
>>               case QEMU_OPTION_compat:
>>                   {
>>                       CompatPolicy *opts_policy;
>> -- 
>> 2.34.1
>>

