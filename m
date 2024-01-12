Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60D82C2E9
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:40:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJcz-0001eS-T2; Fri, 12 Jan 2024 10:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rOJcu-0001a5-UO
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:39:22 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rOJcs-0003kZ-4J
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:39:20 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so7138144a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705073955; x=1705678755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ji4AzAt8oW9catGCi++upzuCMHueC13uWlU3Qn2oOS8=;
 b=oVq5CdQ+6UgBzV0hQgag4xaXCrFx6cQxzxsJS0fIAmxdw+MItae5MEL51dasC4rCSN
 9KKKJcwEh7QUgwVb5/Pbs2OTyxXdni38ajWeYdH58I3XVO8ed/sv7aQ+oiF/pGMW8Qi4
 4o68LwhBGxjhi2Bvq3HLxWeSjoCXXz3JlKhLwlWxg6MpSHc+CW4rd0FtOnIQNCcG1T/n
 QBdgwitt6yhvIuPwvzjjudL53Sr/ObLRTQMsewTIUKVMRhGPiD08DuiFZXUFTbeE4pIi
 rCqBaCFGqVE4/dZ9PHJLbUZWSaeVdUkzzkXwSVtseY/6CMx2x2Sf23Wv3cl90sk0RiU1
 jv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705073955; x=1705678755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ji4AzAt8oW9catGCi++upzuCMHueC13uWlU3Qn2oOS8=;
 b=U9hxx7TBTD5p88vHTwlaPl+tEBE/0Je+4MQmaokgQjDE9h++pgyJynu0dy5t3tJPzP
 /3ICeRAZAUJXJGTw2NlXs+wJHxcP0qtJBh4HLqoBvIx3lf1q9CkybuQXH6ZO/wGpae3U
 Jor2IFVP6HLiwOjrrwtmqb7qRa4NvFHP2VYEc9fVXcjK/OjfKZYlXZhm0QjvqDuIePnV
 UlRWjhuR2nV7bs1CfSn7Hdx64Ty66TwBlEkaivdKoESPt7JXseXxP0BFuLAovFIb4eBi
 T6wBUJAH37TZE0BnbhVtCTIJltMbA9fa9jD4mmHdGcjHh5ZRRELIbPNku7JgPMaEYp4y
 y1mQ==
X-Gm-Message-State: AOJu0YxlYyZMyn3kiOMc0OoSEAMv+hjdJJ7+zG+naJfQ3crXiH3LFzhj
 KILWV7/1C2HhYKJtRdBVr8FxrWzjDtzEUw==
X-Google-Smtp-Source: AGHT+IHjdDWvbGjpiu+YDp1A5uu7pZQam7x8wWGbLJ/Neud7n1IYnfizGSBdCOaDzVPeMxi6bisqmg==
X-Received: by 2002:aa7:ccd1:0:b0:554:ac4e:e4a4 with SMTP id
 y17-20020aa7ccd1000000b00554ac4ee4a4mr730521edt.21.1705073955265; 
 Fri, 12 Jan 2024 07:39:15 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.145])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a50ed0e000000b005550192159bsm1918184eds.62.2024.01.12.07.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 07:39:14 -0800 (PST)
Message-ID: <7f24e391-e3ba-462c-ba30-2ea7ddb62795@linaro.org>
Date: Fri, 12 Jan 2024 16:39:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] qemu-options: Remove the deprecated -singlestep option
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240112100059.965041-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Thomas

+Laurent & Peter

On 12/1/24 11:00, Thomas Huth wrote:
> It's been marked as deprecated since QEMU 8.1, so it should be fine
> to remove this now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/about/deprecated.rst       |  6 ------
>   docs/about/removed-features.rst |  7 +++++++
>   system/vl.c                     | 18 +-----------------
>   qemu-options.hx                 |  8 --------
>   4 files changed, 8 insertions(+), 31 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index b50cfe596b..81a5149f1e 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -63,12 +63,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
>   However, short-form booleans are deprecated and full explicit ``arg_name=on``
>   form is preferred.
>   
> -``-singlestep`` (since 8.1)
> -'''''''''''''''''''''''''''
> -
> -The ``-singlestep`` option has been turned into an accelerator property,
> -and given a name that better reflects what it actually does.
> -Use ``-accel tcg,one-insn-per-tb=on`` instead.
>   
>   User-mode emulator command line arguments
>   -----------------------------------------
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index a8546f4787..d5c60ff47f 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -482,6 +482,13 @@ Use ``-run-with async-teardown=on`` instead.
>   
>   Use ``-run-with chroot=dir`` instead.
>   
> +``-singlestep`` (removed in 9.0)
> +''''''''''''''''''''''''''''''''
> +
> +The ``-singlestep`` option has been turned into an accelerator property,
> +and given a name that better reflects what it actually does.
> +Use ``-accel tcg,one-insn-per-tb=on`` instead.
> +
>   
>   QEMU Machine Protocol (QMP) commands
>   ------------------------------------
> diff --git a/system/vl.c b/system/vl.c
> index c125fb9079..809f867bcc 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -181,7 +181,6 @@ static const char *log_file;
>   static bool list_data_dirs;
>   static const char *qtest_chrdev;
>   static const char *qtest_log;
> -static bool opt_one_insn_per_tb;
>   
>   static int has_defaults = 1;
>   static int default_audio = 1;
> @@ -2308,19 +2307,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>       qemu_opt_foreach(opts, accelerator_set_property,
>                        accel,
>                        &error_fatal);
> -    /*
> -     * If legacy -singlestep option is set, honour it for TCG and
> -     * silently ignore for any other accelerator (which is how this
> -     * option has always behaved).
> -     */
> -    if (opt_one_insn_per_tb) {
> -        /*
> -         * This will always succeed for TCG, and we want to ignore
> -         * the error from trying to set a nonexistent property
> -         * on any other accelerator.
> -         */
> -        object_property_set_bool(OBJECT(accel), "one-insn-per-tb", true, NULL);
> -    }
> +
>       ret = accel_init_machine(accel, current_machine);
>       if (ret < 0) {
>           if (!qtest_with_kvm || ret != -ENOENT) {
> @@ -3057,9 +3044,6 @@ void qemu_init(int argc, char **argv)
>               case QEMU_OPTION_bios:
>                   qdict_put_str(machine_opts_dict, "firmware", optarg);
>                   break;
> -            case QEMU_OPTION_singlestep:
> -                opt_one_insn_per_tb = true;
> -                break;
>               case QEMU_OPTION_S:
>                   autostart = 0;
>                   break;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9be6beb5a0..033fa873e4 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4357,14 +4357,6 @@ SRST
>       from a script.
>   ERST
>   
> -DEF("singlestep", 0, QEMU_OPTION_singlestep, \
> -    "-singlestep     deprecated synonym for -accel tcg,one-insn-per-tb=on\n", QEMU_ARCH_ALL)
> -SRST
> -``-singlestep``
> -    This is a deprecated synonym for the TCG accelerator property
> -    ``one-insn-per-tb``.
> -ERST
> -
>   DEF("preconfig", 0, QEMU_OPTION_preconfig, \
>       "--preconfig     pause QEMU before machine is initialized (experimental)\n",
>       QEMU_ARCH_ALL)

This is the system part, what about the user part?

StatusInfo::singlestep was deprecated at the same time,
can we remove it?

IOW could we complete your patch with this?

-- >8 --
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index b47763330c..a1ae93664a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -63,17 +63,6 @@ as short-form boolean values, and passed to plugins 
as ``arg_name=on``.
  However, short-form booleans are deprecated and full explicit 
``arg_name=on``
  form is preferred.

-
-User-mode emulator command line arguments
------------------------------------------
-
-``-singlestep`` (since 8.1)
-'''''''''''''''''''''''''''
-
-The ``-singlestep`` option has been given a name that better reflects
-what it actually does. For both linux-user and bsd-user, use the
-new ``-one-insn-per-tb`` option instead.
-
  QEMU Machine Protocol (QMP) commands
  ------------------------------------

@@ -145,20 +134,6 @@ accepted incorrect commands will return an error. 
Users should make sure that
  all arguments passed to ``device_add`` are consistent with the documented
  property types.

-``StatusInfo`` member ``singlestep`` (since 8.1)
-''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``singlestep`` member of the ``StatusInfo`` returned from the
-``query-status`` command is deprecated. This member has a confusing
-name and it never did what the documentation claimed or what its name
-suggests. We do not believe that anybody is actually using the
-information provided in this member.
-
-The information it reports is whether the TCG JIT is in "one
-instruction per translated block" mode (which can be set on the
-command line or via the HMP, but not via QMP). The information remains
-available via the HMP 'info jit' command.
-
  QEMU Machine Protocol (QMP) events
  ----------------------------------

diff --git a/docs/user/main.rst b/docs/user/main.rst
index f478635396..7e7ad07409 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -98,9 +98,6 @@ Debug options:
     This slows down emulation a lot, but can be useful in some situations,
     such as when trying to analyse the logs produced by the ``-d`` option.

-``-singlestep``
-   This is a deprecated synonym for the ``-one-insn-per-tb`` option.
-
  Environment variables:

  QEMU_STRACE
@@ -251,6 +248,3 @@ Debug options:
     Run the emulation with one guest instruction per translation block.
     This slows down emulation a lot, but can be useful in some situations,
     such as when trying to analyse the logs produced by the ``-d`` option.
-
-``-singlestep``
-   This is a deprecated synonym for the ``-one-insn-per-tb`` option.
diff --git a/qapi/run-state.json b/qapi/run-state.json
index ca05502e0a..08bc99cb85 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -106,25 +106,15 @@
  #
  # @running: true if all VCPUs are runnable, false if not runnable
  #
-# @singlestep: true if using TCG with one guest instruction per
-#     translation block
-#
  # @status: the virtual machine @RunState
  #
  # Features:
  #
-# @deprecated: Member 'singlestep' is deprecated (with no
-#     replacement).
-#
  # Since: 0.14
  #
-# Notes: @singlestep is enabled on the command line with '-accel
-#     tcg,one-insn-per-tb=on', or with the HMP 'one-insn-per-tb'
-#     command.
  ##
  { 'struct': 'StatusInfo',
    'data': {'running': 'bool',
-           'singlestep': { 'type': 'bool', 'features': [ 'deprecated' ]},
             'status': 'RunState'} }

  ##
@@ -140,7 +130,6 @@
  #
  # -> { "execute": "query-status" }
  # <- { "return": { "running": true,
-#                  "singlestep": false,
  #                  "status": "running" } }
  ##
  { 'command': 'query-status', 'returns': 'StatusInfo',
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 4de226d211..e5efb7b845 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -163,7 +163,6 @@ static void usage(void)
             "                  (use '-d help' for a list of log items)\n"
             "-D logfile        write logs to 'logfile' (default stderr)\n"
             "-one-insn-per-tb  run with one guest instruction per 
emulated TB\n"
-           "-singlestep       deprecated synonym for -one-insn-per-tb\n"
             "-strace           log system calls\n"
             "-trace 
[[enable=]<pattern>][,events=<file>][,file=<file>]\n"
             "                  specify tracing options\n"
@@ -391,7 +390,7 @@ int main(int argc, char **argv)
              (void) envlist_unsetenv(envlist, "LD_PRELOAD");
          } else if (!strcmp(r, "seed")) {
              seed_optarg = optarg;
-        } else if (!strcmp(r, "singlestep") || !strcmp(r, 
"one-insn-per-tb")) {
+        } else if (!strcmp(r, "one-insn-per-tb")) {
              opt_one_insn_per_tb = true;
          } else if (!strcmp(r, "strace")) {
              do_strace = 1;
diff --git a/linux-user/main.c b/linux-user/main.c
index 0cdaf30d34..c9470eeccf 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -500,8 +500,6 @@ static const struct qemu_argument arg_table[] = {
      {"one-insn-per-tb",
                     "QEMU_ONE_INSN_PER_TB",  false, 
handle_arg_one_insn_per_tb,
       "",           "run with one guest instruction per emulated TB"},
-    {"singlestep", "QEMU_SINGLESTEP",  false, handle_arg_one_insn_per_tb,
-     "",           "deprecated synonym for -one-insn-per-tb"},
      {"strace",     "QEMU_STRACE",      false, handle_arg_strace,
       "",           "log system calls"},
      {"seed",       "QEMU_RAND_SEED",   true,  handle_arg_seed,
diff --git a/system/runstate.c b/system/runstate.c
index fb07b7b71a..d6ab860eca 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -242,15 +242,7 @@ bool runstate_needs_reset(void)
  StatusInfo *qmp_query_status(Error **errp)
  {
      StatusInfo *info = g_malloc0(sizeof(*info));
-    AccelState *accel = current_accel();

-    /*
-     * We ignore errors, which will happen if the accelerator
-     * is not TCG. "singlestep" is meaningless for other accelerators,
-     * so we will set the StatusInfo field to false for those.
-     */
-    info->singlestep = object_property_get_bool(OBJECT(accel),
-                                                "one-insn-per-tb", NULL);
      info->running = runstate_is_running();
      info->status = current_run_state;

diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
index fd9c2e52a5..9277643853 100644
--- a/tests/qemu-iotests/183.out
+++ b/tests/qemu-iotests/183.out
@@ -30,13 +30,13 @@ read 65536/65536 bytes at offset 0
         'arguments': { 'uri': 'unix:SOCK_DIR/migrate', 'blk': true } }
  {"return": {}}
  { 'execute': 'query-status' }
-{"return": {"status": "postmigrate", "singlestep": false, "running": 
false}}
+{"return": {"status": "postmigrate", "running": false}}

  === Do some I/O on the destination ===

  { 'execute': 'query-status' }
  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, 
"event": "RESUME"}
-{"return": {"status": "running", "singlestep": false, "running": true}}
+{"return": {"status": "running", "running": true}}
  { 'execute': 'human-monitor-command',
         'arguments': { 'command-line':
                        'qemu-io disk "read -P 0x55 0 64k"' } }
diff --git a/tests/qemu-iotests/234.out b/tests/qemu-iotests/234.out
index 692976d1c6..ac8b64350c 100644
--- a/tests/qemu-iotests/234.out
+++ b/tests/qemu-iotests/234.out
@@ -15,8 +15,8 @@ Starting migration to B...
  {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": 
{"microseconds": "USECS", "seconds": "SECS"}}
  completed
  completed
-{"return": {"running": false, "singlestep": false, "status": 
"postmigrate"}}
-{"return": {"running": true, "singlestep": false, "status": "running"}}
+{"return": {"running": false, "status": "postmigrate"}}
+{"return": {"running": true, "status": "running"}}
  Add a second parent to drive0-file...
  {"return": {}}
  Restart A with -incoming and second parent...
@@ -32,5 +32,5 @@ Starting migration back to A...
  {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": 
{"microseconds": "USECS", "seconds": "SECS"}}
  completed
  completed
-{"return": {"running": true, "singlestep": false, "status": "running"}}
-{"return": {"running": false, "singlestep": false, "status": 
"postmigrate"}}
+{"return": {"running": true, "status": "running"}}
+{"return": {"running": false, "status": "postmigrate"}}
diff --git a/tests/qemu-iotests/262.out b/tests/qemu-iotests/262.out
index 8e04c496c4..b8a2d3598d 100644
--- a/tests/qemu-iotests/262.out
+++ b/tests/qemu-iotests/262.out
@@ -13,5 +13,5 @@ Starting migration to B...
  {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": 
{"microseconds": "USECS", "seconds": "SECS"}}
  completed
  completed
-{"return": {"running": false, "singlestep": false, "status": 
"postmigrate"}}
-{"return": {"running": true, "singlestep": false, "status": "running"}}
+{"return": {"running": false, "status": "postmigrate"}}
+{"return": {"running": true, "status": "running"}}
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
index c75f437c00..546dbb4a68 100644
--- a/tests/qemu-iotests/280.out
+++ b/tests/qemu-iotests/280.out
@@ -12,7 +12,7 @@ Enabling migration QMP events on VM...
  VM is now stopped:
  completed
  {"execute": "query-status", "arguments": {}}
-{"return": {"running": false, "singlestep": false, "status": 
"postmigrate"}}
+{"return": {"running": false, "status": "postmigrate"}}

  === Create a snapshot of the disk image ===
  {"execute": "blockdev-create", "arguments": {"job-id": "job0", 
"options": {"driver": "file", "filename": "TEST_DIR/PID-top", "size": 0}}}

---

