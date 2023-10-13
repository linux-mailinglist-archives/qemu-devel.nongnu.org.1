Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 891CC7C7F8F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:09:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD55-0005Dt-PJ; Fri, 13 Oct 2023 03:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD52-0004x8-LS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:32 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4z-0007Cz-9L
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:32 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5046bf37ec1so2439126e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183967; x=1697788767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBO0NNb0V3LfMWL/3wFiC/lYqJ328EdfxocrGVrl+P8=;
 b=ULqq7gjEcnjwllzT9MYcQ2IYe874TQsdm54uqO53fTX4TgPDgCW8RBWqcjYsXBMucX
 kKYbDonaIcpZmyNZ6d3gIntNcw+PJlKFKlJn2JrO24d8nBfnDuCm/X5fjI3Ryds1k9mD
 o98ziPRdENqe0aDU6xXg9+FOykgLCSyslR41CzsCfnojAkr2JMI98M1xgTw2ZBBGmKse
 Y/Pts+sVoCFp43I7gWsQ4tUcPjlQD1P2orXtdPXh0ko99rpf4yVXdvPr+SlBwI7Bnq7z
 oHLUmGfhr4GRpUuVfLCUs/PweQhy/oWcAML5PcYk0+PL2GPhxrY8dC85fzd61eX73pet
 fbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183967; x=1697788767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBO0NNb0V3LfMWL/3wFiC/lYqJ328EdfxocrGVrl+P8=;
 b=KcEWtYMX67FlXyuPTbxV25waLd3N4751cP/fcC9suX0YIBEmsCmYIDtuN2bgU/9H3L
 KGOlQOEVpqsXy1qzAn1ODJkbSRu6gTymq194aJSwrKVetedOjrPiU6jnAATg8T9whVyQ
 iih9FbM83zY1OpHl6QOK17gagT0NEorUQUahZSvuEfP57liMitA0yiSH6+5+LcxLFDOq
 ME4/LBNYYSgykpBmbPy6zJMClgkbKLa32rpKl/hpG0baLOTi6XpFMqzQhZhkoYuR0G91
 u7GgCV2VQsPtXNA+teKYn32Em26DUAOF0Ch113ZTbQNNVs8sB9ZzSCYjx+OJ+b17ytdM
 OaGQ==
X-Gm-Message-State: AOJu0Yy4ouxSBxvtKry53tpreQybxAqIbKnLnx7E6j7oQccj4HW7D5ir
 g4yLYAYvGjKkA/qwziPI0WzDvR3s0qddaSdXldE=
X-Google-Smtp-Source: AGHT+IH0MDBXYuHOmoWN28n8mtGUHmFogQOArOL+8R8+00zQJEzpj7NmgLx7/6DrmQKWmQIspKA1ZA==
X-Received: by 2002:ac2:528a:0:b0:507:9689:f446 with SMTP id
 q10-20020ac2528a000000b005079689f446mr1918136lfm.42.1697183966979; 
 Fri, 13 Oct 2023 00:59:26 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:26 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [RFC PATCH v2 53/78] nbd: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:20 +0300
Message-Id: <53cd0864892e6764e5487c2b698f122d02afb9a2.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 nbd/client.c | 4 ++--
 nbd/common.c | 2 +-
 qemu-nbd.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 29ffc609a4..04507249b2 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1014,102 +1014,102 @@ static int nbd_negotiate_finish_oldstyle(QIOChannel *ioc, NBDExportInfo *info,
 /*
  * nbd_receive_negotiate:
  * Connect to server, complete negotiation, and move into transmission phase.
  * Returns: negative errno: failure talking to server
  *          0: server is connected
  */
 int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp)
 {
     ERRP_GUARD();
     int result;
     bool zeroes;
     bool base_allocation = info->base_allocation;
 
     assert(info->name && strlen(info->name) <= NBD_MAX_STRING_SIZE);
     trace_nbd_receive_negotiate_name(info->name);
 
     result = nbd_start_negotiate(ioc, tlscreds, hostname, outioc,
                                  info->mode, &zeroes, errp);
     if (result < 0) {
         return result;
     }
 
     info->mode = result;
     info->base_allocation = false;
     if (tlscreds && *outioc) {
         ioc = *outioc;
     }
 
     switch (info->mode) {
     case NBD_MODE_EXTENDED:
     case NBD_MODE_STRUCTURED:
         if (base_allocation) {
             result = nbd_negotiate_simple_meta_context(ioc, info, errp);
             if (result < 0) {
                 return -EINVAL;
             }
             info->base_allocation = result == 1;
         }
-        /* fall through */
+        fallthrough;
     case NBD_MODE_SIMPLE:
         /* Try NBD_OPT_GO first - if it works, we are done (it
          * also gives us a good message if the server requires
          * TLS).  If it is not available, fall back to
          * NBD_OPT_LIST for nicer error messages about a missing
          * export, then use NBD_OPT_EXPORT_NAME.  */
         result = nbd_opt_info_or_go(ioc, NBD_OPT_GO, info, errp);
         if (result < 0) {
             return -EINVAL;
         }
         if (result > 0) {
             return 0;
         }
         /* Check our desired export is present in the
          * server export list. Since NBD_OPT_EXPORT_NAME
          * cannot return an error message, running this
          * query gives us better error reporting if the
          * export name is not available.
          */
         if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
             return -EINVAL;
         }
-        /* fall through */
+        fallthrough;
     case NBD_MODE_EXPORT_NAME:
         /* write the export name request */
         if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->name,
                                     errp) < 0) {
             return -EINVAL;
         }
 
         /* Read the response */
         if (nbd_read64(ioc, &info->size, "export length", errp) < 0) {
             return -EINVAL;
         }
 
         if (nbd_read16(ioc, &info->flags, "export flags", errp) < 0) {
             return -EINVAL;
         }
         break;
     case NBD_MODE_OLDSTYLE:
         if (*info->name) {
             error_setg(errp, "Server does not support non-empty export names");
             return -EINVAL;
         }
         if (nbd_negotiate_finish_oldstyle(ioc, info, errp) < 0) {
             return -EINVAL;
         }
         break;
     default:
         g_assert_not_reached();
     }
 
     trace_nbd_receive_negotiate_size_flags(info->size, info->flags);
     if (zeroes && nbd_drop(ioc, 124, errp) < 0) {
         error_prepend(errp, "Failed to read reserved block: ");
         return -EINVAL;
     }
     return 0;
 }
 
 /* Clean up result of nbd_receive_export_list */
diff --git a/nbd/common.c b/nbd/common.c
index 3247c1d618..1140ea0888 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -222,37 +222,37 @@ const char *nbd_err_lookup(int err)
 int nbd_errno_to_system_errno(int err)
 {
     int ret;
     switch (err) {
     case NBD_SUCCESS:
         ret = 0;
         break;
     case NBD_EPERM:
         ret = EPERM;
         break;
     case NBD_EIO:
         ret = EIO;
         break;
     case NBD_ENOMEM:
         ret = ENOMEM;
         break;
     case NBD_ENOSPC:
         ret = ENOSPC;
         break;
     case NBD_EOVERFLOW:
         ret = EOVERFLOW;
         break;
     case NBD_ENOTSUP:
         ret = ENOTSUP;
         break;
     case NBD_ESHUTDOWN:
         ret = ESHUTDOWN;
         break;
     default:
         trace_nbd_unknown_error(err);
-        /* fallthrough */
+        fallthrough;
     case NBD_EINVAL:
         ret = EINVAL;
         break;
     }
     return ret;
 }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 186e6468b1..41e50208a5 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -528,704 +528,704 @@ static void qemu_nbd_shutdown(void)
 int main(int argc, char **argv)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
     uint64_t dev_offset = 0;
     bool readonly = false;
     bool disconnect = false;
     const char *bindto = NULL;
     const char *port = NULL;
     char *sockpath = NULL;
     QemuOpts *sn_opts = NULL;
     const char *sn_id_or_name = NULL;
     const char *sopt = "hVb:o:p:rsnc:dvk:e:f:tl:x:T:D:AB:L";
     struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
         { "bind", required_argument, NULL, 'b' },
         { "port", required_argument, NULL, 'p' },
         { "socket", required_argument, NULL, 'k' },
         { "offset", required_argument, NULL, 'o' },
         { "read-only", no_argument, NULL, 'r' },
         { "allocation-depth", no_argument, NULL, 'A' },
         { "bitmap", required_argument, NULL, 'B' },
         { "connect", required_argument, NULL, 'c' },
         { "disconnect", no_argument, NULL, 'd' },
         { "list", no_argument, NULL, 'L' },
         { "snapshot", no_argument, NULL, 's' },
         { "load-snapshot", required_argument, NULL, 'l' },
         { "nocache", no_argument, NULL, 'n' },
         { "cache", required_argument, NULL, QEMU_NBD_OPT_CACHE },
         { "aio", required_argument, NULL, QEMU_NBD_OPT_AIO },
         { "discard", required_argument, NULL, QEMU_NBD_OPT_DISCARD },
         { "detect-zeroes", required_argument, NULL,
           QEMU_NBD_OPT_DETECT_ZEROES },
         { "shared", required_argument, NULL, 'e' },
         { "format", required_argument, NULL, 'f' },
         { "persistent", no_argument, NULL, 't' },
         { "verbose", no_argument, NULL, 'v' },
         { "object", required_argument, NULL, QEMU_NBD_OPT_OBJECT },
         { "export-name", required_argument, NULL, 'x' },
         { "description", required_argument, NULL, 'D' },
         { "tls-creds", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
         { "tls-hostname", required_argument, NULL, QEMU_NBD_OPT_TLSHOSTNAME },
         { "tls-authz", required_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
         { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
         { "trace", required_argument, NULL, 'T' },
         { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
         { "pid-file", required_argument, NULL, QEMU_NBD_OPT_PID_FILE },
         { "selinux-label", required_argument, NULL,
           QEMU_NBD_OPT_SELINUX_LABEL },
         { NULL, 0, NULL, 0 }
     };
     int ch;
     int opt_ind = 0;
     int flags = BDRV_O_RDWR;
     int ret = 0;
     bool seen_cache = false;
     bool seen_discard = false;
     bool seen_aio = false;
     pthread_t client_thread;
     const char *fmt = NULL;
     Error *local_err = NULL;
     BlockdevDetectZeroesOptions detect_zeroes = BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
     QDict *options = NULL;
     const char *export_name = NULL; /* defaults to "" later for server mode */
     const char *export_description = NULL;
     BlockDirtyBitmapOrStrList *bitmaps = NULL;
     bool alloc_depth = false;
     const char *tlscredsid = NULL;
     const char *tlshostname = NULL;
     bool imageOpts = false;
     bool writethrough = false; /* Client will flush as needed. */
     bool list = false;
     unsigned socket_activation;
     const char *pid_file_name = NULL;
     const char *selinux_label = NULL;
     BlockExportOptions *export_opts;
     struct NbdClientOpts opts = {
         .fork_process = false,
         .verbose = false,
         .device = NULL,
         .srcpath = NULL,
         .saddr = NULL,
         .old_stderr = STDOUT_FILENO,
     };
 
 #ifdef CONFIG_POSIX
     os_setup_early_signal_handling();
     os_setup_signal_handling();
 #endif
 
     socket_init();
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
     qcrypto_init(&error_fatal);
 
     module_call_init(MODULE_INIT_QOM);
     qemu_add_opts(&qemu_trace_opts);
     qemu_init_exec_dir(argv[0]);
 
     while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
         switch (ch) {
         case 's':
             flags |= BDRV_O_SNAPSHOT;
             break;
         case 'n':
             optarg = (char *) "none";
-            /* fallthrough */
+            fallthrough;
         case QEMU_NBD_OPT_CACHE:
             if (seen_cache) {
                 error_report("-n and --cache can only be specified once");
                 exit(EXIT_FAILURE);
             }
             seen_cache = true;
             if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) == -1) {
                 error_report("Invalid cache mode `%s'", optarg);
                 exit(EXIT_FAILURE);
             }
             break;
         case QEMU_NBD_OPT_AIO:
             if (seen_aio) {
                 error_report("--aio can only be specified once");
                 exit(EXIT_FAILURE);
             }
             seen_aio = true;
             if (bdrv_parse_aio(optarg, &flags) < 0) {
                 error_report("Invalid aio mode '%s'", optarg);
                 exit(EXIT_FAILURE);
             }
             break;
         case QEMU_NBD_OPT_DISCARD:
             if (seen_discard) {
                 error_report("--discard can only be specified once");
                 exit(EXIT_FAILURE);
             }
             seen_discard = true;
             if (bdrv_parse_discard_flags(optarg, &flags) == -1) {
                 error_report("Invalid discard mode `%s'", optarg);
                 exit(EXIT_FAILURE);
             }
             break;
         case QEMU_NBD_OPT_DETECT_ZEROES:
             detect_zeroes =
                 qapi_enum_parse(&BlockdevDetectZeroesOptions_lookup,
                                 optarg,
                                 BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF,
                                 &local_err);
             if (local_err) {
                 error_reportf_err(local_err,
                                   "Failed to parse detect_zeroes mode: ");
                 exit(EXIT_FAILURE);
             }
             if (detect_zeroes == BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP &&
                 !(flags & BDRV_O_UNMAP)) {
                 error_report("setting detect-zeroes to unmap is not allowed "
                              "without setting discard operation to unmap");
                 exit(EXIT_FAILURE);
             }
             break;
         case 'b':
             bindto = optarg;
             break;
         case 'p':
             port = optarg;
             break;
         case 'o':
             if (qemu_strtou64(optarg, NULL, 0, &dev_offset) < 0) {
                 error_report("Invalid offset '%s'", optarg);
                 exit(EXIT_FAILURE);
             }
             break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
                 sn_opts = qemu_opts_parse_noisily(&internal_snapshot_opts,
                                                   optarg, false);
                 if (!sn_opts) {
                     error_report("Failed in parsing snapshot param `%s'",
                                  optarg);
                     exit(EXIT_FAILURE);
                 }
             } else {
                 sn_id_or_name = optarg;
             }
-            /* fall through */
+            fallthrough;
         case 'r':
             readonly = true;
             flags &= ~BDRV_O_RDWR;
             break;
         case 'A':
             alloc_depth = true;
             break;
         case 'B':
             {
                 BlockDirtyBitmapOrStr *el = g_new(BlockDirtyBitmapOrStr, 1);
                 *el = (BlockDirtyBitmapOrStr) {
                     .type = QTYPE_QSTRING,
                     .u.local = g_strdup(optarg),
                 };
                 QAPI_LIST_PREPEND(bitmaps, el);
             }
             break;
         case 'k':
             sockpath = optarg;
             if (sockpath[0] != '/') {
                 error_report("socket path must be absolute");
                 exit(EXIT_FAILURE);
             }
             break;
         case 'd':
             disconnect = true;
             break;
         case 'c':
             opts.device = optarg;
             break;
         case 'e':
             if (qemu_strtoi(optarg, NULL, 0, &shared) < 0 ||
                 shared < 0) {
                 error_report("Invalid shared device number '%s'", optarg);
                 exit(EXIT_FAILURE);
             }
             break;
         case 'f':
             fmt = optarg;
             break;
         case 't':
             persistent = 1;
             break;
         case 'x':
             export_name = optarg;
             if (strlen(export_name) > NBD_MAX_STRING_SIZE) {
                 error_report("export name '%s' too long", export_name);
                 exit(EXIT_FAILURE);
             }
             break;
         case 'D':
             export_description = optarg;
             if (strlen(export_description) > NBD_MAX_STRING_SIZE) {
                 error_report("export description '%s' too long",
                              export_description);
                 exit(EXIT_FAILURE);
             }
             break;
         case 'v':
             opts.verbose = true;
             break;
         case 'V':
             version(argv[0]);
             exit(0);
             break;
         case 'h':
             usage(argv[0]);
             exit(0);
             break;
         case '?':
             error_report("Try `%s --help' for more information.", argv[0]);
             exit(EXIT_FAILURE);
         case QEMU_NBD_OPT_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
         case QEMU_NBD_OPT_TLSCREDS:
             tlscredsid = optarg;
             break;
         case QEMU_NBD_OPT_TLSHOSTNAME:
             tlshostname = optarg;
             break;
         case QEMU_NBD_OPT_IMAGE_OPTS:
             imageOpts = true;
             break;
         case 'T':
             trace_opt_parse(optarg);
             break;
         case QEMU_NBD_OPT_TLSAUTHZ:
             tlsauthz = optarg;
             break;
         case QEMU_NBD_OPT_FORK:
             opts.fork_process = true;
             break;
         case 'L':
             list = true;
             break;
         case QEMU_NBD_OPT_PID_FILE:
             pid_file_name = optarg;
             break;
         case QEMU_NBD_OPT_SELINUX_LABEL:
             selinux_label = optarg;
             break;
         }
     }
 
     if (list) {
         if (argc != optind) {
             error_report("List mode is incompatible with a file name");
             exit(EXIT_FAILURE);
         }
         if (export_name || export_description || dev_offset ||
             opts.device || disconnect || fmt || sn_id_or_name || bitmaps ||
             alloc_depth || seen_aio || seen_discard || seen_cache) {
             error_report("List mode is incompatible with per-device settings");
             exit(EXIT_FAILURE);
         }
         if (opts.fork_process) {
             error_report("List mode is incompatible with forking");
             exit(EXIT_FAILURE);
         }
     } else if ((argc - optind) != 1) {
         error_report("Invalid number of arguments");
         error_printf("Try `%s --help' for more information.\n", argv[0]);
         exit(EXIT_FAILURE);
     } else if (!export_name) {
         export_name = "";
     }
 
     if (!trace_init_backends()) {
         exit(1);
     }
     trace_init_file();
     qemu_set_log(LOG_TRACE, &error_fatal);
 
     socket_activation = check_socket_activation();
     if (socket_activation == 0) {
         if (!sockpath) {
             setup_address_and_port(&bindto, &port);
         }
     } else {
         /* Using socket activation - check user didn't use -p etc. */
         const char *err_msg = socket_activation_validate_opts(opts.device,
                                                               sockpath,
                                                               bindto, port,
                                                               selinux_label,
                                                               list);
         if (err_msg != NULL) {
             error_report("%s", err_msg);
             exit(EXIT_FAILURE);
         }
 
         /* qemu-nbd can only listen on a single socket.  */
         if (socket_activation > 1) {
             error_report("qemu-nbd does not support socket activation with %s > 1",
                          "LISTEN_FDS");
             exit(EXIT_FAILURE);
         }
     }
 
     if (tlscredsid) {
         if (opts.device) {
             error_report("TLS is not supported with a host device");
             exit(EXIT_FAILURE);
         }
         if (tlsauthz && list) {
             error_report("TLS authorization is incompatible with export list");
             exit(EXIT_FAILURE);
         }
         if (tlshostname && !list) {
             error_report("TLS hostname is only supported with export list");
             exit(EXIT_FAILURE);
         }
         tlscreds = nbd_get_tls_creds(tlscredsid, list, &local_err);
         if (local_err) {
             error_reportf_err(local_err, "Failed to get TLS creds: ");
             exit(EXIT_FAILURE);
         }
     } else {
         if (tlsauthz) {
             error_report("--tls-authz is not permitted without --tls-creds");
             exit(EXIT_FAILURE);
         }
         if (tlshostname) {
             error_report("--tls-hostname is not permitted without --tls-creds");
             exit(EXIT_FAILURE);
         }
     }
 
     if (selinux_label) {
 #ifdef CONFIG_SELINUX
         if (sockpath == NULL && opts.device == NULL) {
             error_report("--selinux-label is not permitted without --socket");
             exit(EXIT_FAILURE);
         }
 #else
         error_report("SELinux support not enabled in this binary");
         exit(EXIT_FAILURE);
 #endif
     }
 
     if (list) {
         opts.saddr = nbd_build_socket_address(sockpath, bindto, port);
         return qemu_nbd_client_list(opts.saddr, tlscreds,
                                     tlshostname ? tlshostname : bindto);
     }
 
 #if !HAVE_NBD_DEVICE
     if (disconnect || opts.device) {
         error_report("Kernel /dev/nbdN support not available");
         exit(EXIT_FAILURE);
     }
 #else /* HAVE_NBD_DEVICE */
     if (disconnect) {
         int nbdfd = open(argv[optind], O_RDWR);
         if (nbdfd < 0) {
             error_report("Cannot open %s: %s", argv[optind],
                          strerror(errno));
             exit(EXIT_FAILURE);
         }
         nbd_disconnect(nbdfd);
 
         close(nbdfd);
 
         printf("%s disconnected\n", argv[optind]);
 
         return 0;
     }
 #endif
 
     if ((opts.device && !opts.verbose) || opts.fork_process) {
 #ifndef WIN32
         g_autoptr(GError) err = NULL;
         int stderr_fd[2];
         pid_t pid;
 
         if (!g_unix_open_pipe(stderr_fd, FD_CLOEXEC, &err)) {
             error_report("Error setting up communication pipe: %s",
                          err->message);
             exit(EXIT_FAILURE);
         }
 
         /* Now daemonize, but keep a communication channel open to
          * print errors and exit with the proper status code.
          */
         pid = fork();
         if (pid < 0) {
             error_report("Failed to fork: %s", strerror(errno));
             exit(EXIT_FAILURE);
         } else if (pid == 0) {
             int saved_errno;
 
             close(stderr_fd[0]);
 
             /* Remember parent's stderr if we will be restoring it. */
             if (opts.verbose /* fork_process is set */) {
                 opts.old_stderr = dup(STDERR_FILENO);
                 if (opts.old_stderr < 0) {
                     error_report("Could not dup original stderr: %s",
                                  strerror(errno));
                     exit(EXIT_FAILURE);
                 }
             }
 
             ret = qemu_daemon(1, 0);
             saved_errno = errno;    /* dup2 will overwrite error below */
 
             /* Temporarily redirect stderr to the parent's pipe...  */
             if (dup2(stderr_fd[1], STDERR_FILENO) < 0) {
                 char str[256];
                 snprintf(str, sizeof(str),
                          "%s: Failed to link stderr to the pipe: %s\n",
                          g_get_prgname(), strerror(errno));
                 /*
                  * We are unable to use error_report() here as we need to get
                  * stderr pointed to the parent's pipe. Write to that pipe
                  * manually.
                  */
                 ret = write(stderr_fd[1], str, strlen(str));
                 exit(EXIT_FAILURE);
             }
 
             if (ret < 0) {
                 error_report("Failed to daemonize: %s", strerror(saved_errno));
                 exit(EXIT_FAILURE);
             }
 
             /* ... close the descriptor we inherited and go on.  */
             close(stderr_fd[1]);
         } else {
             bool errors = false;
             char *buf;
 
             /* In the parent.  Print error messages from the child until
              * it closes the pipe.
              */
             close(stderr_fd[1]);
             buf = g_malloc(1024);
             while ((ret = read(stderr_fd[0], buf, 1024)) > 0) {
                 errors = true;
                 ret = qemu_write_full(STDERR_FILENO, buf, ret);
                 if (ret < 0) {
                     exit(EXIT_FAILURE);
                 }
             }
             if (ret < 0) {
                 error_report("Cannot read from daemon: %s",
                              strerror(errno));
                 exit(EXIT_FAILURE);
             }
 
             /* Usually the daemon should not print any message.
              * Exit with zero status in that case.
              */
             exit(errors);
         }
 #else /* WIN32 */
         error_report("Unable to fork into background on Windows hosts");
         exit(EXIT_FAILURE);
 #endif /* WIN32 */
     }
 
     if (opts.device != NULL && sockpath == NULL) {
         sockpath = g_malloc(128);
         snprintf(sockpath, 128, SOCKET_PATH, basename(opts.device));
     }
 
     server = qio_net_listener_new();
     if (socket_activation == 0) {
         int backlog;
 
         if (persistent || shared == 0) {
             backlog = SOMAXCONN;
         } else {
             backlog = MIN(shared, SOMAXCONN);
         }
 #ifdef CONFIG_SELINUX
         if (selinux_label && setsockcreatecon_raw(selinux_label) == -1) {
             error_report("Cannot set SELinux socket create context to %s: %s",
                          selinux_label, strerror(errno));
             exit(EXIT_FAILURE);
         }
 #endif
         opts.saddr = nbd_build_socket_address(sockpath, bindto, port);
         if (qio_net_listener_open_sync(server, opts.saddr, backlog,
                                        &local_err) < 0) {
             object_unref(OBJECT(server));
             error_report_err(local_err);
             exit(EXIT_FAILURE);
         }
 #ifdef CONFIG_SELINUX
         if (selinux_label && setsockcreatecon_raw(NULL) == -1) {
             error_report("Cannot clear SELinux socket create context: %s",
                          strerror(errno));
             exit(EXIT_FAILURE);
         }
 #endif
     } else {
         size_t i;
         /* See comment in check_socket_activation above. */
         for (i = 0; i < socket_activation; i++) {
             QIOChannelSocket *sioc;
             sioc = qio_channel_socket_new_fd(FIRST_SOCKET_ACTIVATION_FD + i,
                                              &local_err);
             if (sioc == NULL) {
                 object_unref(OBJECT(server));
                 error_reportf_err(local_err,
                                   "Failed to use socket activation: ");
                 exit(EXIT_FAILURE);
             }
             qio_net_listener_add(server, sioc);
             object_unref(OBJECT(sioc));
         }
     }
 
     qemu_init_main_loop(&error_fatal);
     bdrv_init();
     atexit(qemu_nbd_shutdown);
 
     opts.srcpath = argv[optind];
     if (imageOpts) {
         QemuOpts *o;
         if (fmt) {
             error_report("--image-opts and -f are mutually exclusive");
             exit(EXIT_FAILURE);
         }
         o = qemu_opts_parse_noisily(&file_opts, opts.srcpath, true);
         if (!o) {
             qemu_opts_reset(&file_opts);
             exit(EXIT_FAILURE);
         }
         options = qemu_opts_to_qdict(o, NULL);
         qemu_opts_reset(&file_opts);
         blk = blk_new_open(NULL, NULL, options, flags, &local_err);
     } else {
         if (fmt) {
             options = qdict_new();
             qdict_put_str(options, "driver", fmt);
         }
         blk = blk_new_open(opts.srcpath, NULL, options, flags, &local_err);
     }
 
     if (!blk) {
         error_reportf_err(local_err, "Failed to blk_new_open '%s': ",
                           argv[optind]);
         exit(EXIT_FAILURE);
     }
     bs = blk_bs(blk);
 
     if (dev_offset) {
         QDict *raw_opts = qdict_new();
         qdict_put_str(raw_opts, "driver", "raw");
         qdict_put_str(raw_opts, "file", bs->node_name);
         qdict_put_int(raw_opts, "offset", dev_offset);
 
         aio_context_acquire(qemu_get_aio_context());
         bs = bdrv_open(NULL, NULL, raw_opts, flags, &error_fatal);
         aio_context_release(qemu_get_aio_context());
 
         blk_remove_bs(blk);
         blk_insert_bs(blk, bs, &error_fatal);
         bdrv_unref(bs);
     }
 
     blk_set_enable_write_cache(blk, !writethrough);
 
     if (sn_opts) {
         ret = bdrv_snapshot_load_tmp(bs,
                                      qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
                                      qemu_opt_get(sn_opts, SNAPSHOT_OPT_NAME),
                                      &local_err);
     } else if (sn_id_or_name) {
         ret = bdrv_snapshot_load_tmp_by_id_or_name(bs, sn_id_or_name,
                                                    &local_err);
     }
     if (ret < 0) {
         error_reportf_err(local_err, "Failed to load snapshot: ");
         exit(EXIT_FAILURE);
     }
 
     bs->detect_zeroes = detect_zeroes;
 
     nbd_server_is_qemu_nbd(shared);
 
     export_opts = g_new(BlockExportOptions, 1);
     *export_opts = (BlockExportOptions) {
         .type               = BLOCK_EXPORT_TYPE_NBD,
         .id                 = g_strdup("qemu-nbd-export"),
         .node_name          = g_strdup(bdrv_get_node_name(bs)),
         .has_writethrough   = true,
         .writethrough       = writethrough,
         .has_writable       = true,
         .writable           = !readonly,
         .u.nbd = {
             .name                 = g_strdup(export_name),
             .description          = g_strdup(export_description),
             .has_bitmaps          = !!bitmaps,
             .bitmaps              = bitmaps,
             .has_allocation_depth = alloc_depth,
             .allocation_depth     = alloc_depth,
         },
     };
     blk_exp_add(export_opts, &error_fatal);
     qapi_free_BlockExportOptions(export_opts);
 
     if (opts.device) {
 #if HAVE_NBD_DEVICE
         ret = pthread_create(&client_thread, NULL, nbd_client_thread, &opts);
         if (ret != 0) {
             error_report("Failed to create client thread: %s", strerror(ret));
             exit(EXIT_FAILURE);
         }
 #endif
     } else {
         /* Shut up GCC warnings.  */
         memset(&client_thread, 0, sizeof(client_thread));
     }
 
     nbd_update_server_watch();
 
     if (pid_file_name) {
         qemu_write_pidfile(pid_file_name, &error_fatal);
     }
 
     /* now when the initialization is (almost) complete, chdir("/")
      * to free any busy filesystems */
     if (chdir("/") < 0) {
         error_report("Could not chdir to root directory: %s",
                      strerror(errno));
         exit(EXIT_FAILURE);
     }
 
     if (opts.fork_process) {
         nbd_client_release_pipe(opts.old_stderr);
     }
 
     state = RUNNING;
     do {
         main_loop_wait(false);
         if (state == TERMINATE) {
             blk_exp_close_all();
             state = TERMINATED;
         }
     } while (state != TERMINATED);
 
     blk_unref(blk);
     if (sockpath) {
         unlink(sockpath);
     }
 
     qemu_opts_del(sn_opts);
 
     if (opts.device) {
         void *result;
         pthread_join(client_thread, &result);
         ret = (intptr_t)result;
         exit(ret);
     } else {
         exit(EXIT_SUCCESS);
     }
 }
-- 
2.39.2


