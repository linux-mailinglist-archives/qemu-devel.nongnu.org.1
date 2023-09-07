Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AFD7972C5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEgV-000345-RN; Thu, 07 Sep 2023 09:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgP-000329-1z
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:30 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qeEgM-000834-HT
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:04:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bf11b1c7d0so14969725ad.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694091865; x=1694696665;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKnBqBACpdkOcg5+pbvAuwZwBRdK/oxFRTqdjZK/py8=;
 b=Rc2BoaJyB7SFEDE0/udexL6mqpuVIJeEhpEvY1A6MHB6oPCgUauJTkB59UQ51CLHeO
 eHOKbwLbWA9QPcfMYSVHt6a8e21z2lbRLnpkQxxTQisbT1gSt0OyQt3QXiQDEluqE9c9
 jmsTQpx3/nZrIEbXly95kVQ5v2R1QzZc0U0GsdIsnmohnHQWbz/wc8RJO4g+fMhC6lGG
 LgAzpCPYGuIjfciR6fFLAqSREfXIz8w6Flpx39ZOBlBzarhskpeq8II3GMJTI0j/1b1G
 VbDnFu/ktPlGLoPrB7LwpL9DnQQ5X60sIJ6igfOri6SywRD4QSuGXWpARvbTXLlXnidR
 qlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091865; x=1694696665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKnBqBACpdkOcg5+pbvAuwZwBRdK/oxFRTqdjZK/py8=;
 b=ilOO2XRDoij/0V0CzKo3yd0CIbewC84Q8lfoqiH+dCu07yO/hyaDUbSLOVGUytuRpn
 7qBgDK9o50WXnfrV4BwBZhQX55PHJYk4NlGB3yW2EZj0+ukKTxk60+C3odiSz3McZ5xu
 JsPDLs9ukYQBa9LZSLHI51ffCr1i0G0HmVqrWZQrrldzqZxTweEu+QTECBPd/MYsYTWy
 Ovl6sDB/0KEACoM78pTC5g1FtgNg9J5YxZOVQVsoBq67SmD35EpvnQf7sPXvb7KAf3vh
 4YWxt6exwNFpCBrmAvs02j3iO5mYiCc5Z31NbFiyfuX9qatkHltJYxLME5GGQ1gNMRXA
 bVsg==
X-Gm-Message-State: AOJu0Yyv1kDNDeCuVgyulaWTEIkhkaCaEcHtTFUcVJAloBgiSmeJyzom
 svsVmFHUMKK5fNdvLPk4csn/RJ6qVN9XZ91Vz8bjTA==
X-Google-Smtp-Source: AGHT+IGTbkYlQ06tMReqaRFVTofhGBoKSy3PTDfgnwfrVsTYYmX8oHXgtvktfNr0MRmbKt+XFZEuOA==
X-Received: by 2002:a17:902:ce88:b0:1bc:2fe1:1821 with SMTP id
 f8-20020a170902ce8800b001bc2fe11821mr3576695plg.17.1694091864618; 
 Thu, 07 Sep 2023 06:04:24 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a170902fe1800b001b0358848b0sm12821913plj.161.2023.09.07.06.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:04:24 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, stefanha@redhat.com,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v3 3/5] Update subprojects/libvfio-user
Date: Thu,  7 Sep 2023 06:04:08 -0700
Message-Id: <20230907130410.498935-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907130410.498935-1-mnissler@rivosinc.com>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Brings in assorted bug fixes. In particular, "Fix address calculation
for message-based DMA" corrects a bug in DMA address calculation which
is necessary to get DMA across VFIO-user messages working.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 subprojects/libvfio-user.wrap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
index 416955ca45..135667a40d 100644
--- a/subprojects/libvfio-user.wrap
+++ b/subprojects/libvfio-user.wrap
@@ -1,4 +1,4 @@
 [wrap-git]
 url = https://gitlab.com/qemu-project/libvfio-user.git
-revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+revision = f63ef82ad01821417df488cef7ec1fd94c3883fa
 depth = 1
-- 
2.34.1


