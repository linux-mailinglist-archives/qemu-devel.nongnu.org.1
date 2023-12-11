Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F240380C1A9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 08:14:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCaTV-0007Tg-7U; Mon, 11 Dec 2023 02:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rCaTQ-0007S6-Dd
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 02:13:05 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rCaTN-0005O0-RJ
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 02:13:03 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ce6b62746dso2344900b3a.2
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 23:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1702278780; x=1702883580;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+K7EXH6z5cxbjBPNRPPoIKGz7ihR0RlHvVKrh/SMeM=;
 b=uYNb1i0Fk7OxZxHNvJLxegG2b81xlNQjTCkEuHZOpbAC174Fuwffwt1v4oQGzEg/Ab
 acTxeOMwYIQNFFlb4AboAIyfSY7SWxvOaJar4/NHQDxLi99Y7AbIyZjQygyIlgGmTbzs
 bvAbFOGgcRIxXXut0GinZ0saF9exYWP+rVxiX6MYvej48eOSuuaKoUTs1BAdoCKeSqLd
 gnp955XqZCizxQgxuWes8ciNeMgzARZshAIriTPYR5zBBVWzodAI2s9UlPo/LoNKYgzi
 322b3REZlPdec4gKiRMZd10g3VUm7J6Oiu9b2GE0a3UUTR7eIMO2sYRi0JiwJz0pJ1nE
 bKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702278780; x=1702883580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+K7EXH6z5cxbjBPNRPPoIKGz7ihR0RlHvVKrh/SMeM=;
 b=nP+pghalwn1nAqkQW49lsbgrMI0syunIHELdqJN213I7gQA3W8YeXTbMw8WF8bi0JD
 blTMZQu6VnWZOAdzj3wvI0zAv8X2MMzNskqyIF98MAyJOjAXpHKLRl9rvbpYj4ZpJH+M
 llOdOHEQiV70X8Vuxy884DT0JVi8OP0WJDOHTd6J0FtGHRIOOv6JgZkkr9h70HlIwhGN
 HRw0Zy3sKXVRhYm97cny5/9SvPo8mX0C2MkiXGzrXP6fx6rTYrwey+dwTvxjLvJRotO1
 7zH+mWwKCIwrEWmLXP8w1h48aj61InlnWRxMhEy2jmbnhxpgQA37Y4lPWiq5f5hEZPVi
 L9+g==
X-Gm-Message-State: AOJu0Ywcv24Nc86xnoCe59xZHrsve6BW9UEUJrOp3dV7+u3XNb5C97mG
 tEqkO5hK/hElYwpW2kx9Jg43HSYcgK9jARLgrVc=
X-Google-Smtp-Source: AGHT+IGbqbN/ZyMX0ZzzsTkekSiiE1iqMPRNOOYmrDi8GQqrD/Ot8Vm6gG8rYvyzYUWOwwx93FGAag==
X-Received: by 2002:a05:6a20:1047:b0:187:1015:bf9c with SMTP id
 gt7-20020a056a20104700b001871015bf9cmr1530395pzc.10.1702278780385; 
 Sun, 10 Dec 2023 23:13:00 -0800 (PST)
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 v23-20020a170902e8d700b001d08e080042sm5842150plg.43.2023.12.10.23.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 23:13:00 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] system/memory.c: support unaligned access
Date: Mon, 11 Dec 2023 16:12:03 +0900
Message-Id: <20231211071204.30156-2-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The previous code ignored 'impl.unaligned' and handled unaligned accesses
as is. But this implementation cannot emulate specific registers of some
devices that allow unaligned access such as xHCI Host Controller Capability
Registers.
This commit checks 'impl.unaligned' and if it is false, QEMU emulates
unaligned access with multiple aligned access.

Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
---
 system/memory.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 798b6c0a17..b0caa90fef 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -539,6 +539,9 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
     unsigned i;
     MemTxResult r = MEMTX_OK;
     bool reentrancy_guard_applied = false;
+    hwaddr aligned_addr;
+    unsigned corrected_size = size;
+    signed align_diff = 0;
 
     if (!access_size_min) {
         access_size_min = 1;
@@ -560,18 +563,25 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
         reentrancy_guard_applied = true;
     }
 
-    /* FIXME: support unaligned access? */
     access_size = MAX(MIN(size, access_size_max), access_size_min);
     access_mask = MAKE_64BIT_MASK(0, access_size * 8);
+    if (!mr->ops->impl.unaligned) {
+        aligned_addr = addr & ~(access_size - 1);
+        align_diff = addr - aligned_addr;
+        corrected_size = size < access_size ? access_size :
+                            size + (align_diff > 0 ? access_size : 0);
+        addr = aligned_addr;
+    }
     if (memory_region_big_endian(mr)) {
-        for (i = 0; i < size; i += access_size) {
+        for (i = 0; i < corrected_size; i += access_size) {
             r |= access_fn(mr, addr + i, value, access_size,
-                        (size - access_size - i) * 8, access_mask, attrs);
+                        (size - access_size - i + align_diff) * 8,
+                        access_mask, attrs);
         }
     } else {
-        for (i = 0; i < size; i += access_size) {
-            r |= access_fn(mr, addr + i, value, access_size, i * 8,
-                        access_mask, attrs);
+        for (i = 0; i < corrected_size; i += access_size) {
+            r |= access_fn(mr, addr + i, value, access_size,
+                        ((signed)i - align_diff) * 8, access_mask, attrs);
         }
     }
     if (mr->dev && reentrancy_guard_applied) {
-- 
2.39.2


