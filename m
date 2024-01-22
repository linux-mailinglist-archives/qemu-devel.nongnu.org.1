Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 773F58371A0
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:02:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzX5-0005aa-8F; Mon, 22 Jan 2024 14:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX2-0005ZF-T0; Mon, 22 Jan 2024 14:00:28 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzX1-00023t-1t; Mon, 22 Jan 2024 14:00:28 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-557dcb0f870so3969030a12.2; 
 Mon, 22 Jan 2024 11:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705950024; x=1706554824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTarc3jgbW0f6VY8YmALJoPGDUg3nmJKlHXVbN5rD1c=;
 b=iKaI+bMyOx7EW+831vmSAfB/CeXbiHXXAQWoBaZLACmQa3oPz8JDKd+wUlWVDzd+pU
 /iPng+BUD42UyXAAdvFOE5iKb/fm71ves9ngXeVWP/x16uBlbsu0JT8+cZSiPofPCBXr
 9qQzQVrnlt97jch4SFdpdiJQR35VM3c4I9UinqjmEUei678YhR5DK1OoGwBk1Q9/9xuy
 WHw9bu7FbeKoKdmMvVmgEufNU3bL+S5QhnrtW2G1pWky1giJfpL30lINJHD+YDymYBI9
 b0LYZsvHwC1MkgEXcsKquqzZrsHnXMyatCNGeCEjA9gCjCY87Ofc1djMI16BucPdIeKI
 g6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705950024; x=1706554824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTarc3jgbW0f6VY8YmALJoPGDUg3nmJKlHXVbN5rD1c=;
 b=gXSC6QHiHhjhW1e7ijnpbpodFXcNSMLhM9HFqjaq+gtxAJo7sqwzLyKlLGY4Jxi21q
 L0Hs1TffSF8VdVldADhN8W5TuCjcFAwrUejZkGICEzgbjM4T1bRQ8VDlEQM2N9SRHeCQ
 TtnTZEOaMrIuyXMIcHc7UYTNlgVU20PFP3nRA3VOjGDlIjKqItM2LDNSfhcB9ltgbFMx
 ZLGMU5xduAxe9pE8RlNpMe6bktb2DIv7lKq9w9pjTHLqbf6qWFwqV9jig6tX74iDxi74
 etnqCOd77/JpGi9+ONdYzS1zWR/juU1xEIO0uoXK7HWrwd3IxRsIouSxL6bUqBre/ykb
 ClOg==
X-Gm-Message-State: AOJu0Yy2jawA2SilSvkltwgrxt0D3fViDGeVrH5MO52CF6i++4suNzes
 HnhcqvnH7MJougaQaphX9trFFFTxYkNpLDgC9nG1v1jWESJsN6MESMkNJFbXMR4=
X-Google-Smtp-Source: AGHT+IHgbl01qfHFVjd/LEGzkOQkMIZrlS67HN5LgAl40n0RasClh09LveU4emiUN+D8+gQkscNaqg==
X-Received: by 2002:a17:906:a10e:b0:a2c:e804:e2ec with SMTP id
 t14-20020a170906a10e00b00a2ce804e2ecmr2112462ejy.51.1705950024238; 
 Mon, 22 Jan 2024 11:00:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:367:1500:fa08:d4d:b569:ac2d])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a170906a38300b00a298d735a1bsm13842413ejz.149.2024.01.22.11.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 11:00:23 -0800 (PST)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 dmitry.fomichev@wdc.com, hare@suse.de, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Sam Li <faithilikerun@gmail.com>
Subject: [RFC v3 1/7] docs/qcow2: add zd_extension_size option to the zoned
 format feature
Date: Mon, 22 Jan 2024 20:00:07 +0100
Message-Id: <20240122190013.41302-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122190013.41302-1-faithilikerun@gmail.com>
References: <20240122190013.41302-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The NVMe ZNS command set has the zone descriptor extension feature for
associating the data to a zone. Devices that supports ZAC/ZBC have zero
zone descriptor extension size.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 docs/interop/qcow2.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index a8dd4c3b15..106477d9ad 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -436,6 +436,15 @@ The fields of the zoned extension are:
                    The offset of zoned metadata structure in the contained
                    image, in bytes.
 
+         44 - 51:  zd_extension_size
+                   The size of zone descriptor extension data in bytes.
+                   The value must be a multiple of 64.
+
+                   The zone descriptor extension feature is associating data
+                   to a zone which is only available in the NVMe ZNS command
+                   set. A value of zero indicates the feature is not
+                   available.
+
 == Full disk encryption header pointer ==
 
 The full disk encryption header must be present if, and only if, the
-- 
2.40.1


