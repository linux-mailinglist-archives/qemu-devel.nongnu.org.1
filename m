Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFA17C9996
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs26N-0004GM-4x; Sun, 15 Oct 2023 10:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs26K-0004Fg-SV
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:28:17 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs26I-0003Jo-IW
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:28:16 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-57f0f81b2aeso2066145eaf.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697380093; x=1697984893;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJvuvj66EsS91S2m+8/F/LwLUlH8M44s6LWhiQhjrYg=;
 b=McciN+O9SrrB9p665M2NsQP5bjiPW2e0G3GUN67kTZsCsXNUKqD2FnJv7hK7k/s0mF
 kYIruvbqkTTGq6nAysaYzdWjQI6s1h+xMiTxqaHRriijtMo+zOfnQ0OO9BfHurw4Pchu
 K36A8AbAwrAFgkexSN1B/E/eFv20y7NBu/vdj5QiBd23i5sReKOX+M8OXl5tA68w9IZ1
 OqPLJiITrzwk9bWfnl6za/NYk4MCXzeZWZknfoZd+Mu6/mBjr7HELuE9hjwZBRZBKKyZ
 CVwv8NBhZaKfCdZsAOH4n5lsAG2iipnoovsXgs99zTnOvbR7I8OrBIHEqNjG17AiF8Lg
 qZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697380093; x=1697984893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJvuvj66EsS91S2m+8/F/LwLUlH8M44s6LWhiQhjrYg=;
 b=Jno+4e5A2hmffIHwPlA5+Twt7JIYLR9cM10K3KFAlQKe0pXhYCNrGmKidgoqFoYweZ
 lSUSNotpGwnhcLbZjEccmHVA/B18HFauLoT+Uu9l8pdHurVitUhrGZHZubr7n8ur1+XX
 jf3pbsU0tF204lnmrtDIG+Dsnl5lCaSGD7AAm8xSfMvzMTGXivuBkCS8VVViyh0qxyoA
 Nwl3UHOD7zG4SSX7feLSEP6GrN+wZ+lzOQbNarW3onlW1yW49h3BadKa1nnq+c/eiS0D
 /oUlt8E/EUz9NUQ50wVjk4jv0xvDX/sCBq3CxZZQO8FYPV58Rj93ctLjHeY74qxKIfvO
 0Znw==
X-Gm-Message-State: AOJu0YztMjXz2EgBVwcgdyWs4vI/yQiuetuvEFAp3ImDqaxawmOTXwdK
 2KM5e6IMMt+BPjhDGe0ZIaa+49Kyv5gvQ1bEUiP7Qg==
X-Google-Smtp-Source: AGHT+IFYJ7VL3oFJDlva87pZAogAIXLzWnBUolBcQpyfYNsmQseO7g65u/qOLQvm2Lh/HbMQbSuXVg==
X-Received: by 2002:a05:6358:5e0a:b0:139:9fc3:eade with SMTP id
 q10-20020a0563585e0a00b001399fc3eademr30300873rwn.29.1697380093040; 
 Sun, 15 Oct 2023 07:28:13 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 e9-20020aa78249000000b006934390d0c5sm16863448pfn.175.2023.10.15.07.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:28:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC PATCH v2 3/3] docs: Describe eBPF hash reporting
Date: Sun, 15 Oct 2023 23:27:45 +0900
Message-ID: <20231015142755.261808-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015142755.261808-1-akihiko.odaki@daynix.com>
References: <20231015142755.261808-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

eBPF hash reporting is now available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/ebpf_rss.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/devel/ebpf_rss.rst b/docs/devel/ebpf_rss.rst
index 4a68682b31..b015a8a78b 100644
--- a/docs/devel/ebpf_rss.rst
+++ b/docs/devel/ebpf_rss.rst
@@ -27,7 +27,8 @@ Simplified decision formula:
 
 Not for all packets, the hash can/should be calculated.
 
-Note: currently, eBPF RSS does not support hash reporting.
+Note: eBPF hash reporting a kernel and libbpf patched with:
+https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.com/
 
 eBPF RSS turned on by different combinations of vhost-net, vitrio-net and tap configurations:
 
@@ -43,7 +44,7 @@ eBPF RSS turned on by different combinations of vhost-net, vitrio-net and tap co
 
         tap,vhost=off & virtio-net-pci,rss=on,hash=on
 
-- eBPF is used, hash population feature is not reported to the guest:
+- eBPF is used, hash population feature is reported to the guest:
 
         tap,vhost=on & virtio-net-pci,rss=on,hash=on
 
-- 
2.42.0


