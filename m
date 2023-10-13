Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBC77C7F79
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:06:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5j-0008CE-Io; Fri, 13 Oct 2023 04:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5L-0007o6-Sc
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:52 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5H-0007MB-TS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:51 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5068dab8c00so2352051e87.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183985; x=1697788785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZR8NeoEsoCx6t5MLu/JlvHClUZCj9rdecCGKjqBBgM=;
 b=tSZOc2xSKhzEQv/wXBhQsIr2NCOHhsn6VkTAauq0KXnledByrOk8Owd0G74kyrRO/j
 TMXa7bj5NsTFZlKEcGjQW8lFF70zgGmHfvVuLgjsGEpU9TmgIX8Pwsm4W+ej5qnwqZ2z
 IVl+fWl5/KRNqXkfNF79b2VqHE7hPthd4u1AccYanwze/A7zWCA5nVzcIcCKMS4naqWb
 I5jFBGVa+2WJXa+Fgj+JIZXQvMQtGVTjt6uOUZUSCSREbKRHDy/5vdz6GI/AHesL9jJb
 /opeu7irZCcDEcld7SYuf0lv07VS0Dl00dDyoA9LFBmRsgMiB3ZtmPZp1LIeNqg6L2Fs
 L14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183985; x=1697788785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZR8NeoEsoCx6t5MLu/JlvHClUZCj9rdecCGKjqBBgM=;
 b=HLuEmL+PoeG2Xpcjz7/nF+u6gWRnYe+BjMOeNvQEjvsl10EicAuGWltLPlKvhA1Ffc
 oTQqVT+WBpfVSX0cNH+rjFTUzyg2ezy1HYjgQOMHOh3wqdG5SQjiAELKqJgGYbNHfR16
 /K3ourKJ/pjJexXNiayGlWHsB3UQdK3h8hxXsok/S+cvRRSNlVAa/GP2ZD3Wp8AkfNlr
 We5k2fGLZ7oyuhSqdLin8JwdUd1adRskKeeoSVEjrbikVvQT100F3W3oU+ysoQx1RjT8
 yfxCnhYTqflGon0SG717JLN5ZvAdw/wUkGiEDmIxcM1hzArgFIoc/JwQ8rUgaK9BXHTw
 UC4A==
X-Gm-Message-State: AOJu0YzpIH5TsnDMMVdl745n9vPONbWO+oEMaPZSyycB+/f/ibYUM6AK
 bcnGdt21xdZYReB4fbWhwBdTpA+POr+VO/GKwxU=
X-Google-Smtp-Source: AGHT+IHR4up+qGnqJrEZCgrYak7X/c0UPs/imQxwSKdj1CBX3bT3IwZvMl4lwBdP++WmI3+7nbFX6w==
X-Received: by 2002:ac2:5e21:0:b0:500:aa41:9d67 with SMTP id
 o1-20020ac25e21000000b00500aa419d67mr17545836lfg.8.1697183984944; 
 Fri, 13 Oct 2023 00:59:44 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:44 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 61/78] semihosting: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:28 +0300
Message-Id: <20d71c473f821078d83e13d977c975035aa45f94.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x133.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 semihosting/arm-compat-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 329ea11260..c7d32cfca0 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -354,446 +354,446 @@ static const uint8_t featurefile_data[] = {
 /*
  * Do a semihosting call.
  *
  * The specification always says that the "return register" either
  * returns a specific value or is corrupted, so we don't need to
  * report to our caller whether we are returning a value or trying to
  * leave the register unchanged.
  */
 void do_common_semihosting(CPUState *cs)
 {
     CPUArchState *env = cpu_env(cs);
     target_ulong args;
     target_ulong arg0, arg1, arg2, arg3;
     target_ulong ul_ret;
     char * s;
     int nr;
     int64_t elapsed;
 
     nr = common_semi_arg(cs, 0) & 0xffffffffU;
     args = common_semi_arg(cs, 1);
 
     switch (nr) {
     case TARGET_SYS_OPEN:
     {
         int ret, err = 0;
         int hostfd;
 
         GET_ARG(0);
         GET_ARG(1);
         GET_ARG(2);
         s = lock_user_string(arg0);
         if (!s) {
             goto do_fault;
         }
         if (arg1 >= 12) {
             unlock_user(s, arg0, 0);
             common_semi_cb(cs, -1, EINVAL);
             break;
         }
 
         if (strcmp(s, ":tt") == 0) {
             /*
              * We implement SH_EXT_STDOUT_STDERR, so:
              *  open for read == stdin
              *  open for write == stdout
              *  open for append == stderr
              */
             if (arg1 < 4) {
                 hostfd = STDIN_FILENO;
             } else if (arg1 < 8) {
                 hostfd = STDOUT_FILENO;
             } else {
                 hostfd = STDERR_FILENO;
             }
             ret = alloc_guestfd();
             associate_guestfd(ret, hostfd);
         } else if (strcmp(s, ":semihosting-features") == 0) {
             /* We must fail opens for modes other than 0 ('r') or 1 ('rb') */
             if (arg1 != 0 && arg1 != 1) {
                 ret = -1;
                 err = EACCES;
             } else {
                 ret = alloc_guestfd();
                 staticfile_guestfd(ret, featurefile_data,
                                    sizeof(featurefile_data));
             }
         } else {
             unlock_user(s, arg0, 0);
             semihost_sys_open(cs, common_semi_cb, arg0, arg2 + 1,
                               gdb_open_modeflags[arg1], 0644);
             break;
         }
         unlock_user(s, arg0, 0);
         common_semi_cb(cs, ret, err);
         break;
     }
 
     case TARGET_SYS_CLOSE:
         GET_ARG(0);
         semihost_sys_close(cs, common_semi_cb, arg0);
         break;
 
     case TARGET_SYS_WRITEC:
         /*
          * FIXME: the byte to be written is in a target_ulong slot,
          * which means this is wrong for a big-endian guest.
          */
         semihost_sys_write_gf(cs, common_semi_dead_cb,
                               &console_out_gf, args, 1);
         break;
 
     case TARGET_SYS_WRITE0:
         {
             ssize_t len = target_strlen(args);
             if (len < 0) {
                 common_semi_dead_cb(cs, -1, EFAULT);
             } else {
                 semihost_sys_write_gf(cs, common_semi_dead_cb,
                                       &console_out_gf, args, len);
             }
         }
         break;
 
     case TARGET_SYS_WRITE:
         GET_ARG(0);
         GET_ARG(1);
         GET_ARG(2);
         semihost_sys_write(cs, common_semi_rw_cb, arg0, arg1, arg2);
         break;
 
     case TARGET_SYS_READ:
         GET_ARG(0);
         GET_ARG(1);
         GET_ARG(2);
         semihost_sys_read(cs, common_semi_rw_cb, arg0, arg1, arg2);
         break;
 
     case TARGET_SYS_READC:
         semihost_sys_read_gf(cs, common_semi_readc_cb, &console_in_gf,
                              common_semi_stack_bottom(cs) - 1, 1);
         break;
 
     case TARGET_SYS_ISERROR:
         GET_ARG(0);
         common_semi_set_ret(cs, (target_long)arg0 < 0);
         break;
 
     case TARGET_SYS_ISTTY:
         GET_ARG(0);
         semihost_sys_isatty(cs, common_semi_istty_cb, arg0);
         break;
 
     case TARGET_SYS_SEEK:
         GET_ARG(0);
         GET_ARG(1);
         semihost_sys_lseek(cs, common_semi_seek_cb, arg0, arg1, GDB_SEEK_SET);
         break;
 
     case TARGET_SYS_FLEN:
         GET_ARG(0);
         semihost_sys_flen(cs, common_semi_flen_fstat_cb, common_semi_cb,
                           arg0, common_semi_flen_buf(cs));
         break;
 
     case TARGET_SYS_TMPNAM:
     {
         int len;
         char *p;
 
         GET_ARG(0);
         GET_ARG(1);
         GET_ARG(2);
         len = asprintf(&s, "%s/qemu-%x%02x", g_get_tmp_dir(),
                        getpid(), (int)arg1 & 0xff);
         if (len < 0) {
             common_semi_set_ret(cs, -1);
             break;
         }
 
         /* Allow for trailing NUL */
         len++;
         /* Make sure there's enough space in the buffer */
         if (len > arg2) {
             free(s);
             common_semi_set_ret(cs, -1);
             break;
         }
         p = lock_user(VERIFY_WRITE, arg0, len, 0);
         if (!p) {
             free(s);
             goto do_fault;
         }
         memcpy(p, s, len);
         unlock_user(p, arg0, len);
         free(s);
         common_semi_set_ret(cs, 0);
         break;
     }
 
     case TARGET_SYS_REMOVE:
         GET_ARG(0);
         GET_ARG(1);
         semihost_sys_remove(cs, common_semi_cb, arg0, arg1 + 1);
         break;
 
     case TARGET_SYS_RENAME:
         GET_ARG(0);
         GET_ARG(1);
         GET_ARG(2);
         GET_ARG(3);
         semihost_sys_rename(cs, common_semi_cb, arg0, arg1 + 1, arg2, arg3 + 1);
         break;
 
     case TARGET_SYS_CLOCK:
         common_semi_set_ret(cs, clock() / (CLOCKS_PER_SEC / 100));
         break;
 
     case TARGET_SYS_TIME:
         ul_ret = time(NULL);
         common_semi_cb(cs, ul_ret, ul_ret == -1 ? errno : 0);
         break;
 
     case TARGET_SYS_SYSTEM:
         GET_ARG(0);
         GET_ARG(1);
         semihost_sys_system(cs, common_semi_cb, arg0, arg1 + 1);
         break;
 
     case TARGET_SYS_ERRNO:
         common_semi_set_ret(cs, get_swi_errno(cs));
         break;
 
     case TARGET_SYS_GET_CMDLINE:
         {
             /* Build a command-line from the original argv.
              *
              * The inputs are:
              *     * arg0, pointer to a buffer of at least the size
              *               specified in arg1.
              *     * arg1, size of the buffer pointed to by arg0 in
              *               bytes.
              *
              * The outputs are:
              *     * arg0, pointer to null-terminated string of the
              *               command line.
              *     * arg1, length of the string pointed to by arg0.
              */
 
             char *output_buffer;
             size_t input_size;
             size_t output_size;
             int status = 0;
 #if !defined(CONFIG_USER_ONLY)
             const char *cmdline;
 #else
             TaskState *ts = cs->opaque;
 #endif
             GET_ARG(0);
             GET_ARG(1);
             input_size = arg1;
             /* Compute the size of the output string.  */
 #if !defined(CONFIG_USER_ONLY)
             cmdline = semihosting_get_cmdline();
             if (cmdline == NULL) {
                 cmdline = ""; /* Default to an empty line. */
             }
             output_size = strlen(cmdline) + 1; /* Count terminating 0. */
 #else
             unsigned int i;
 
             output_size = ts->info->env_strings - ts->info->arg_strings;
             if (!output_size) {
                 /*
                  * We special-case the "empty command line" case (argc==0).
                  * Just provide the terminating 0.
                  */
                 output_size = 1;
             }
 #endif
 
             if (output_size > input_size) {
                 /* Not enough space to store command-line arguments.  */
                 common_semi_cb(cs, -1, E2BIG);
                 break;
             }
 
             /* Adjust the command-line length.  */
             if (SET_ARG(1, output_size - 1)) {
                 /* Couldn't write back to argument block */
                 goto do_fault;
             }
 
             /* Lock the buffer on the ARM side.  */
             output_buffer = lock_user(VERIFY_WRITE, arg0, output_size, 0);
             if (!output_buffer) {
                 goto do_fault;
             }
 
             /* Copy the command-line arguments.  */
 #if !defined(CONFIG_USER_ONLY)
             pstrcpy(output_buffer, output_size, cmdline);
 #else
             if (output_size == 1) {
                 /* Empty command-line.  */
                 output_buffer[0] = '\0';
                 goto out;
             }
 
             if (copy_from_user(output_buffer, ts->info->arg_strings,
                                output_size)) {
                 unlock_user(output_buffer, arg0, 0);
                 goto do_fault;
             }
 
             /* Separate arguments by white spaces.  */
             for (i = 0; i < output_size - 1; i++) {
                 if (output_buffer[i] == 0) {
                     output_buffer[i] = ' ';
                 }
             }
         out:
 #endif
             /* Unlock the buffer on the ARM side.  */
             unlock_user(output_buffer, arg0, output_size);
             common_semi_cb(cs, status, 0);
         }
         break;
 
     case TARGET_SYS_HEAPINFO:
         {
             target_ulong retvals[4];
             int i;
 #ifdef CONFIG_USER_ONLY
             TaskState *ts = cs->opaque;
             target_ulong limit;
 #else
             LayoutInfo info = common_semi_find_bases(cs);
 #endif
 
             GET_ARG(0);
 
 #ifdef CONFIG_USER_ONLY
             /*
              * Some C libraries assume the heap immediately follows .bss, so
              * allocate it using sbrk.
              */
             if (!ts->heap_limit) {
                 abi_ulong ret;
 
                 ts->heap_base = do_brk(0);
                 limit = ts->heap_base + COMMON_SEMI_HEAP_SIZE;
                 /* Try a big heap, and reduce the size if that fails.  */
                 for (;;) {
                     ret = do_brk(limit);
                     if (ret >= limit) {
                         break;
                     }
                     limit = (ts->heap_base >> 1) + (limit >> 1);
                 }
                 ts->heap_limit = limit;
             }
 
             retvals[0] = ts->heap_base;
             retvals[1] = ts->heap_limit;
             retvals[2] = ts->stack_base;
             retvals[3] = 0; /* Stack limit.  */
 #else
             retvals[0] = info.heapbase;  /* Heap Base */
             retvals[1] = info.heaplimit; /* Heap Limit */
             retvals[2] = info.heaplimit; /* Stack base */
             retvals[3] = info.heapbase;  /* Stack limit.  */
 #endif
 
             for (i = 0; i < ARRAY_SIZE(retvals); i++) {
                 bool fail;
 
                 if (is_64bit_semihosting(env)) {
                     fail = put_user_u64(retvals[i], arg0 + i * 8);
                 } else {
                     fail = put_user_u32(retvals[i], arg0 + i * 4);
                 }
 
                 if (fail) {
                     /* Couldn't write back to argument block */
                     goto do_fault;
                 }
             }
             common_semi_set_ret(cs, 0);
         }
         break;
 
     case TARGET_SYS_EXIT:
     case TARGET_SYS_EXIT_EXTENDED:
     {
         uint32_t ret;
 
         if (common_semi_sys_exit_extended(cs, nr)) {
             /*
              * The A64 version of SYS_EXIT takes a parameter block,
              * so the application-exit type can return a subcode which
              * is the exit status code from the application.
              * SYS_EXIT_EXTENDED is an a new-in-v2.0 optional function
              * which allows A32/T32 guests to also provide a status code.
              */
             GET_ARG(0);
             GET_ARG(1);
 
             if (arg0 == ADP_Stopped_ApplicationExit) {
                 ret = arg1;
             } else {
                 ret = 1;
             }
         } else {
             /*
              * The A32/T32 version of SYS_EXIT specifies only
              * Stopped_ApplicationExit as normal exit, but does not
              * allow the guest to specify the exit status code.
              * Everything else is considered an error.
              */
             ret = (args == ADP_Stopped_ApplicationExit) ? 0 : 1;
         }
         gdb_exit(ret);
         exit(ret);
     }
 
     case TARGET_SYS_ELAPSED:
         elapsed = get_clock() - clock_start;
         if (sizeof(target_ulong) == 8) {
             if (SET_ARG(0, elapsed)) {
                 goto do_fault;
             }
         } else {
             if (SET_ARG(0, (uint32_t) elapsed) ||
                 SET_ARG(1, (uint32_t) (elapsed >> 32))) {
                 goto do_fault;
             }
         }
         common_semi_set_ret(cs, 0);
         break;
 
     case TARGET_SYS_TICKFREQ:
         /* qemu always uses nsec */
         common_semi_set_ret(cs, 1000000000);
         break;
 
     case TARGET_SYS_SYNCCACHE:
         /*
          * Clean the D-cache and invalidate the I-cache for the specified
          * virtual address range. This is a nop for us since we don't
          * implement caches. This is only present on A64.
          */
         if (common_semi_has_synccache(env)) {
             common_semi_set_ret(cs, 0);
             break;
         }
-        /* fall through */
+        fallthrough;
     default:
         fprintf(stderr, "qemu: Unsupported SemiHosting SWI 0x%02x\n", nr);
         cpu_dump_state(cs, stderr, 0);
         abort();
 
     do_fault:
         common_semi_cb(cs, -1, EFAULT);
         break;
     }
 }
-- 
2.39.2


