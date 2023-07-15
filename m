Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7B7548C1
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:31:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfLL-0007kG-KB; Sat, 15 Jul 2023 09:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.estabrooks@gmail.com>)
 id 1qKVwQ-0007Wr-NY
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 23:27:30 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sean.estabrooks@gmail.com>)
 id 1qKVwP-0004La-DB
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 23:27:30 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1b03ec2015fso2042197fac.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 20:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689391648; x=1691983648;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PYuKBNY4MgVUfIcxHFKck2hD/R1XyOQDmDJpotDVgDc=;
 b=ZxNhXlY5YcfShOq+uMsK1XyUf2JgYs+nyXZMJ+2fMuDrA3jElArvj+xnRbVXoH+hlj
 dZ08wm19pLW0z7dfVTzf7doG50vO6LR01vhAs/n9a2CtgPxxcQFlmV9YCc6K/eVCsWgy
 87RpeUmCSEz5psOaTYm6w5Mye0BO1acLXIiFEZInfgJUvPBo3brDWG7G6RyxtzYoXrxw
 eld7rVTsnyvAaNomHGYy47AWW10Pzi9PK0Z40O/UCi5VB8Az7P0D198k1Vs3rhQePVaX
 V/ooj8l+rxc2sEemVe5AD5GKNVZ4So8PokiAQNS3TPGDzXU8SVRqQmMEb6QYf4PGk8Pn
 n9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689391648; x=1691983648;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PYuKBNY4MgVUfIcxHFKck2hD/R1XyOQDmDJpotDVgDc=;
 b=EqyHML4mpCE/NeJijeZE791Gqx1k96DwHnAhd8mBpfknGvnuzFzzxowCxONtBmVIbt
 eEEKwRzRGlw15X3NEzzmJsfTcf69nmMEdtVXBwwOFt5KqhnFwEy+ixgemR8gtJ1d/2ec
 3eURMCrD87GgzQs9Psos5GCZVN1vaxMy5v4VdrF9LjmmhhaAkYy5wyUutlIEt/4pCJ1Y
 Qr2I+zdhZcFyslLIjYx8OvPKA61UE6+QkrX2fHK5JGcF6qoCsONxZCxHFj01JJxbm9sv
 0FfgmKXCSv1UIXOvIPtMPx0ixgcJ0AavUsRusQxQjnNqrUcxNBolIRviHVQfD2Knx6k0
 hnmw==
X-Gm-Message-State: ABy/qLYrt88WeHooH3u312Y2bq8ZedN+Yzs/ZkpBusAM+mL1FzphMTzD
 Mep2cRPb1dzwl6Gmu92y6qYf+SCqTvsrPbo3LB6nYnpn0uM=
X-Google-Smtp-Source: APBJJlEqHYvWQJannFB8W5zctxDerYF9BZ8i31QDOZ+Zp7ywT3GfEXObEflUaL4tKFHJG8/GdONM9RQUjkmlu/xrpOc=
X-Received: by 2002:a05:6870:a3d2:b0:1b0:218b:8acc with SMTP id
 h18-20020a056870a3d200b001b0218b8accmr8173848oak.7.1689391647597; Fri, 14 Jul
 2023 20:27:27 -0700 (PDT)
MIME-Version: 1.0
From: Sean Estabrooks <sean.estabrooks@gmail.com>
Date: Fri, 14 Jul 2023 23:27:16 -0400
Message-ID: <CAHyVn3Bh9CRgDuOmf7G7Ngwamu8d4cVozAcB2i4ymnnggBXNmg@mail.gmail.com>
Subject: [PATCH] For curses display, recognize a few more control keys
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=sean.estabrooks@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 15 Jul 2023 09:29:47 -0400
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

The curses display handles most control-X keys, and translates
them into their corresponding keycode.  Here we recognize
a few that are missing, Ctrl-@ (null), Ctrl-\ (backslash),
Ctrl-] (right bracket), Ctrl-^ (caret), Ctrl-_ (underscore).

Signed-off-by: Sean Estabrooks <sean.estabrooks@gmail.com>
---
 ui/curses_keys.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/curses_keys.h b/ui/curses_keys.h
index 71e04acdc7..88a2208ed1 100644
--- a/ui/curses_keys.h
+++ b/ui/curses_keys.h
@@ -210,6 +210,12 @@ static const int _curses2keycode[CURSES_CHARS] = {
     ['N' - '@'] = 49 | CNTRL, /* Control + n */
     /* Control + m collides with the keycode for Enter */

+    ['@' - '@']  =  3 | CNTRL, /* Control + @ */
+    /* Control + [ collides with the keycode for Escape */
+    ['\\' - '@'] = 43 | CNTRL, /* Control + Backslash */
+    [']' - '@']  = 27 | CNTRL, /* Control + ] */
+    ['^' - '@']  =  7 | CNTRL, /* Control + ^ */
+    ['_' - '@']  = 12 | CNTRL, /* Control + Underscore */
 };

 static const int _curseskey2keycode[CURSES_KEYS] = {
-- 
2.40.1

