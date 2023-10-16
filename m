Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 316E07C9F42
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsGgz-0004Km-3Q; Mon, 16 Oct 2023 02:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsGgw-0004KC-Rn
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:03:03 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsGgu-0000xM-Ub
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:03:02 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so4020288f8f.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697436178; x=1698040978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nYyuXB75Gv+Dbv+3MPxHevnBlOWcrCwYbrnfZg18a8o=;
 b=rNMF7/Ib27Ih5OA5CsgHfZKQdTypQtF+MWjaMoFe5/NUWrXnZoE4xriGH3a6Fq+hTZ
 jAzndCKHCVkNUMwMiGpRFfiwnkvX8Y9Z/nT6mYllb+7O463512jxzFfqyRCGRr73SFvm
 t3u8JM8h0LZmm15C/h7i1jdDaCJjE9TiElST8UGjbMoHqkPBGU2UNl1flBYzltyskoXl
 clwyQkcsLTAFyLS2b7fQ5qvaJW3eGE1WYM8BVgQ4sKIEgqV6IS+4rsR6rO55HUopB/N9
 bGJNfBbMnTi1iIpUTg49wU9MLFwNu27UbN7K+49ErEq7rEpqghLh/uyR3+ot7A2u5agv
 WEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697436178; x=1698040978;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nYyuXB75Gv+Dbv+3MPxHevnBlOWcrCwYbrnfZg18a8o=;
 b=l6fF3O1nTlLgzhRBI9XTgMnbL4jGB3nv7EEN6mHDaxk75rUf3e7jcH7OLea/5hLXWe
 0etXvsaFVZcUCAECAlWib6V1ZEYvnzpK1A9XozLouyGn5UZ12kfyyHsuXbYioO44ECT0
 D1/aAvCG7MQQVHTpQYTw7tJWPLSrXTu88mZ2PRY1PM6rRaW7GH7R+wZpusNAg308DbsV
 Y8xi1dyyMbsSCc+OhSC6ql4PYLRJiCCgFNLMxfueTX29a+U3Uli+rnzMze+B9MHkaTXB
 PQPPbqiKDMtmd4Z8XXyK0pIMfo7Vap3RxFD+JJ3UZsIV6+Pz6pcz1YbJDo1WesqEGjm5
 4h/g==
X-Gm-Message-State: AOJu0YzZMjbSvUsYklZAnp1zImHhcYMtqn6pZGzHfy4IREhXlAd5gNdy
 BsnJP5LUYx7yiXtv2h1/1H9LC1mQv6eZlZRqC1I=
X-Google-Smtp-Source: AGHT+IF9premts08Q9HdSF+38Ecv+/O1HuHXXcxRxE1QVEjgVByHf4zN++3ft/oRSwHaoNOVnFxzMQ==
X-Received: by 2002:a5d:5348:0:b0:32d:8961:d864 with SMTP id
 t8-20020a5d5348000000b0032d8961d864mr9941103wrv.48.1697436177689; 
 Sun, 15 Oct 2023 23:02:57 -0700 (PDT)
Received: from meli.delivery (adsl-165.37.6.1.tellas.gr. [37.6.1.165])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a5d4482000000b0032d8eecf901sm10218459wrq.3.2023.10.15.23.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:02:56 -0700 (PDT)
Date: Mon, 16 Oct 2023 08:44:55 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Edmund Raile <edmund.raile@proton.me>
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com,
 Edmund Raile <edmund.raile@proton.me>
Subject: Re: [PATCH] qemu-ui-gtk clipboard: fix for freeze-crashes v2
User-Agent: meli 0.8.2
References: <20231014084641.42317-2-edmund.raile@proton.me>
In-Reply-To: <20231014084641.42317-2-edmund.raile@proton.me>
Message-ID: <2ly4u.m34k3bok1e6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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

Hello Edmund,

The reproduction in the bug description sounds convoluted so I will 
focus on the code and patch instead:

First of all, the patch title should not include a `v2`. The versioning 
(reroll count) must go in the `[PATCH]` prefix, e.g. `[PATCH v2]`
Secondly, the commit message should describe what the problem is and how 
the fixes in the patch are a solution for it.

See the "meaningfull commit message" in the QEMU docs.

https://www.qemu.org/docs/master/devel/submitting-a-patch.html

  If your patch fixes a bug in the gitlab bug tracker, please add a line 
  with “Resolves: <URL-of-the-bug>” to the commit message, too. Gitlab 
  can close bugs automatically once commits with the “Resolved:” keyword 
  get merged into the master branch of the project. And if your patch 
  addresses a bug in another public bug tracker, you can also use a line 
  with “Buglink: <URL-of-the-bug>” for reference here, too.

  Example:

  Fixes: 14055ce53c2d ("s390x/tcg: avoid overflows in 
  time2tod/tod2time")
  Resolves: https://gitlab.com/qemu-project/qemu/-/issues/42
  Buglink: https://bugs.launchpad.net/qemu/+bug/1804323``

This information should go before your Signed-off-by: trailer line.

You can still include all that information that should not go into the 
commit message by putting them below the -- line and above the patch, 
see 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#include-version-history-in-patchset-revisions


On Sat, 14 Oct 2023 11:48, Edmund Raile <edmund.raile@proton.me> wrote:
>To not risk breaking anything in the mailing list, I'm starting this 
>new mail thread instead of replying to my first one.

That's the right thing to do, replying to old versions will make it less 
visible to people.

Some code comments follow:

>
>---
> include/ui/clipboard.h |  2 ++
> ui/gtk-clipboard.c     | 34 ++++++++++++++++++++--------------
> 2 files changed, 22 insertions(+), 14 deletions(-)
>
>diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
>index ab6acdbd8a..123c04fc07 100644
>--- a/include/ui/clipboard.h
>+++ b/include/ui/clipboard.h
>@@ -106,6 +106,7 @@ struct QemuClipboardNotify {
>  * @types: clipboard data array (one entry per type).
>  * @has_serial: whether @serial is available.
>  * @serial: the grab serial counter.
>+ * @serial_last: used by GTK UI to discard outdated transaction results.
>  *
>  * Clipboard content data and metadata.
>  */
>@@ -115,6 +116,7 @@ struct QemuClipboardInfo {
>     QemuClipboardSelection selection;
>     bool has_serial;
>     uint32_t serial;
>+    uint32_t serial_last;
>     struct {
>         bool available;
>         bool requested;
>diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
>index 8d8a636fd1..9e96cc2fb5 100644
>--- a/ui/gtk-clipboard.c
>+++ b/ui/gtk-clipboard.c
>@@ -133,26 +133,38 @@ static void gd_clipboard_notify(Notifier *notifier, void *data)
>     }
> }
> 
>+/* asynchronous clipboard text transfer (host -> guest): callback */
>+static void gd_clipboard_transfer_text_to_guest_callback(GtkClipboard *clipboard, const gchar *text, gpointer data)
>+{
>+    QemuClipboardInfo *info = (QemuClipboardInfo *)data;



>+
>+    // serial_last is intentionally not stored as a static in this function as callbacks implementing other data types (e.g. images) need access as well

This line and several others are too long. If you run 
scripts/checkpatch.pl on your patch you will see them reported:

  ERROR: line over 90 characters
  #81: FILE: ui/gtk-clipboard.c:141:
  +    // serial_last is intentionally not stored as a static in this 
  function as callbacks implementing other data types (e.g. images) need 
  access as well

Also, no C99 // comments:

  ERROR: do not use C99 // comments
  #81: FILE: ui/gtk-clipboard.c:141:
  +    // serial_last is intentionally not stored as a static in this 
  function as callbacks implementing other data types (e.g. images) need 
  access as well

In any case I think this comment is not needed.

>+
>+    if (text && (info->serial > info->serial_last)) {
>+        info->types[QEMU_CLIPBOARD_TYPE_TEXT].available = true;
>+        qemu_clipboard_update(info);
>+        info->serial_last = info->serial;
>+    }
>+
>+    qemu_clipboard_info_unref(info);

Does this free `info`? If yes why update its fields in the previous 
line?

--
Manos

