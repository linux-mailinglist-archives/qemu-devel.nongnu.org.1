Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E768B7F77BB
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:25:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2r-0004jd-2P; Fri, 24 Nov 2023 10:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2p-0004jG-HW
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2n-0004CA-V1
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ME9ySWmWeETsR1wf95+J1f76rZI7JX9IiNVE3B8e7TQ=;
 b=N75C6V/rooT5P+V8zVNaLaf+pod21ll175LQxX0Zb4Da/W+ID+pRa+ktC2gkV9CqX352ly
 aAnVlOMvP+uiIM5KDS3A0yPn4CW0MrGzDjOGLl590yuPWWJsFTIb6e51QmmMgD7CTbRue5
 Ueb//Dc5PFFrqAQUitTu2726QP8w57w=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-rm07_lR6Nv-pt_GT_ktqTg-1; Fri, 24 Nov 2023 10:24:36 -0500
X-MC-Unique: rm07_lR6Nv-pt_GT_ktqTg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-41b83b8dbe1so20727711cf.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839475; x=1701444275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ME9ySWmWeETsR1wf95+J1f76rZI7JX9IiNVE3B8e7TQ=;
 b=PSDuJtyEv0lUbvNfYlvl3nGNi5vSgVMIaKTwVIBPrv4AE/h9Jo+rE+OIc4ivtswQTW
 4NX0EdoJLj7UX87YT3hAevf1Kot5BUn2zfatGlsfAQWCXkK2s9YY/R0O5gcZsIXzxOgI
 /Huq4RIqUB936KBKnS2tt1gNwGg8lMTTnhIOmtm/YwlsDsD+R0Fg3bnO94iPUSTTlGpC
 Rk5QFslCfjktRk8B7yy2O27C9lQntAKFYoqexFU4rqNDd9UIEWDC8bl6bRe4y4HG+w5j
 lXrtUa6hKbgefndCnRvhveHg6DCGWjKg6w6vmwaMaYoHwnhD9rcOHovwjqY/BtJ2QDpx
 ev7Q==
X-Gm-Message-State: AOJu0YyXfU8CbyawmD6gFqfGZ/7R+5Aab8v/I0UTy3MjG2h2qvE2WaP2
 al6ecvs/q1kwN6HX8I26JxM60YwvqzX/Z2AczIIe6pcyJiYVkBgmjNNBm3sCTNjU9gesYoCa/Zj
 KP/8HcxbEQAawXec7ugYl0MJGHtoXkmab2tVG92yr+19RNIaZeKMSDipRM435mq8F3dUqsAq7hT
 4=
X-Received: by 2002:a0c:fc10:0:b0:672:5946:ffe7 with SMTP id
 z16-20020a0cfc10000000b006725946ffe7mr2875220qvo.30.1700839474944; 
 Fri, 24 Nov 2023 07:24:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhJR0snMUohtRLVLAmFLrGEpyjXgJvKTCY7Q31mW5yynOSibNR8PK2z3tnDHMOa3VhwDhRwg==
X-Received: by 2002:a0c:fc10:0:b0:672:5946:ffe7 with SMTP id
 z16-20020a0cfc10000000b006725946ffe7mr2875172qvo.30.1700839474587; 
 Fri, 24 Nov 2023 07:24:34 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a0ce209000000b0064f43efc844sm1478815qvl.32.2023.11.24.07.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/10] scripts: adjust url to Coverity tools
Date: Fri, 24 Nov 2023 16:24:08 +0100
Message-ID: <20231124152408.140936-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
References: <20231124152408.140936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The URL to the Coverity tools download has changed; the old one points
to an obsolete version that is not supported anymore.  Adjust to point
to the correct and supported tools.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index 129672c86fa..d56c9b66776 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -116,14 +116,14 @@ update_coverity_tools () {
     cd "$COVERITY_TOOL_BASE"
 
     echo "Checking for new version of coverity build tools..."
-    wget https://scan.coverity.com/download/linux64 --post-data "token=$COVERITY_TOKEN&project=$PROJNAME&md5=1" -O coverity_tool.md5.new
+    wget https://scan.coverity.com/download/cxx/linux64 --post-data "token=$COVERITY_TOKEN&project=$PROJNAME&md5=1" -O coverity_tool.md5.new
 
     if ! cmp -s coverity_tool.md5 coverity_tool.md5.new; then
         # out of date md5 or no md5: download new build tool
         # blow away the old build tool
         echo "Downloading coverity build tools..."
         rm -rf coverity_tool coverity_tool.tgz
-        wget https://scan.coverity.com/download/linux64 --post-data "token=$COVERITY_TOKEN&project=$PROJNAME" -O coverity_tool.tgz
+        wget https://scan.coverity.com/download/cxx/linux64 --post-data "token=$COVERITY_TOKEN&project=$PROJNAME" -O coverity_tool.tgz
         if ! (cat coverity_tool.md5.new; echo "  coverity_tool.tgz") | md5sum -c --status; then
             echo "Downloaded tarball didn't match md5sum!"
             exit 1
-- 
2.43.0


