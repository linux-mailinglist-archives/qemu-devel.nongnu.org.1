Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5E7F2C81
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 13:04:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PUQ-0006G7-Aw; Tue, 21 Nov 2023 07:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5PUO-0006Fe-23
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:04:24 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5PUM-0006wq-CR
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:04:23 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3316ad2bee5so2556859f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 04:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700568261; x=1701173061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EMDUbmyJquT/91SijMkiXaSNWlm7KxQHHDbgxa+tLZk=;
 b=n2ARs5QEDhPo1JVmy62FRrP6H+52ga1wcjMxf3MunZ+joG8qfOOfWLbZlFoprP8Kga
 DQa+n80yvwniXv4gf70hjShNFATUag2kbrEo3j4jC0qEdl0SMC9iASXlCTHq5QXZ7So/
 rPd+CbBckLYbxNSJ/UotpCYHFJfaLNsAQ3DC+PjTgNwtRM1m6vFndoqfNMwfDgsMnxrP
 B5bfUU98TMPNqyQB2hrzYP0HkXJZMIF1cBXmgTFn5LXqByaErPZMP/VB9Xb90V1V0fe2
 oGmS66293ofzYzhOexOrFm3IrfkF/hat9NLZDrERpvlx6K9aJcsptfHHDmAGyZ5HokYd
 AYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700568261; x=1701173061;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EMDUbmyJquT/91SijMkiXaSNWlm7KxQHHDbgxa+tLZk=;
 b=XRr9eb7ZyK3hcMQNlEVDzQxMX/Ih0JOtKqfK6us34cIYqZoTXYZt6Z06iB8x5Dklq6
 ERmTXvpIjVeix2sQQdmWrif/Elg1EDC1YKL8iRG2rcZ2t9OQYQ9dpF+WDHCzyqaqKdoq
 +5F0isvVA2K4aDCGlzdaLDIGcF5DG3toNYVONbB93YMwex8QJd5gBMGCRl9+sMUbTKqc
 5EhWsXtxXwJQuqTNb4eA1NHcpZP2sJTn3zydsK0WJ2VFh7fJuPjKOSa1KRLiDgHwPPmC
 eu2mJeU/KQIO0mblkB14cEKH7WhL+JjcJeb6BUbXSuS9sNktQVBNKvx0qcyslP/+Kel2
 MG7Q==
X-Gm-Message-State: AOJu0YyNWq5IBOhFP8yDRvvJCKNLcXitLH1dw14qhgRRAzJav+wu33j8
 n1HNxQ6SudngwCwHKUd0akvHbQ==
X-Google-Smtp-Source: AGHT+IECTPySgMg/cKvA8HMioWzjnzi2mzmNGpWF7g55vGmKSUeZ6bnRSMrE2b/dNHn6lLc94GR1Vw==
X-Received: by 2002:a5d:5885:0:b0:32f:e1a2:526a with SMTP id
 n5-20020a5d5885000000b0032fe1a2526amr7063301wrf.67.1700568260809; 
 Tue, 21 Nov 2023 04:04:20 -0800 (PST)
Received: from meli.delivery (adsl-75.109.242.226.tellas.gr. [109.242.226.75])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a5d4bc5000000b00332c4055faesm7777977wrt.87.2023.11.21.04.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 04:04:20 -0800 (PST)
Date: Tue, 21 Nov 2023 14:03:15 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH-for-9.0 01/25] memory: Have
 memory_region_init_ram_flags_nomigrate() return a boolean
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-2-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-2-philmd@linaro.org>
Message-ID: <4h2v6.z3bmxgpq3k0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
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

On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Following the example documented since commit e3fe3988d7 ("error:
>Document Error API usage rules"), have cpu_exec_realizefn()
>return a boolean indicating whether an error is set or not.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> include/exec/memory.h | 4 +++-
> system/memory.c       | 4 +++-
> 2 files changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/include/exec/memory.h b/include/exec/memory.h
>index 831f7c996d..f038a7e5cf 100644
>--- a/include/exec/memory.h
>+++ b/include/exec/memory.h
>@@ -1310,8 +1310,10 @@ void memory_region_init_ram_nomigrate(MemoryRegion *mr,
>  *
>  * Note that this function does not do anything to cause the data in the
>  * RAM memory region to be migrated; that is the responsibility of the caller.
>+ *
>+ * Return: true on success, else false setting @errp with error.
>  */
>-void memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>+bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>                                             Object *owner,
>                                             const char *name,
>                                             uint64_t size,
>diff --git a/system/memory.c b/system/memory.c
>index 4d9cb0a7ff..313dbb2544 100644
>--- a/system/memory.c
>+++ b/system/memory.c
>@@ -1583,7 +1583,7 @@ void memory_region_init_ram_nomigrate(MemoryRegion *mr,
>     memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0, errp);
> }
> 
>-void memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>+bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>                                             Object *owner,
>                                             const char *name,
>                                             uint64_t size,
>@@ -1600,7 +1600,9 @@ void memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
>         mr->size = int128_zero();
>         object_unparent(OBJECT(mr));
>         error_propagate(errp, err);
>+        return false;
>     }
>+    return true;
> }
> 
> void memory_region_init_resizeable_ram(MemoryRegion *mr,
>-- 
>2.41.0
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


