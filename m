Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E274E712A3D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:10:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzh-0004GD-P7; Fri, 26 May 2023 12:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzc-0004C6-61
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2ZzZ-0002db-SQ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sd3T10HXiJPTxzvEoZFcDCGXr7r+Y/M31alTpJVCV8w=;
 b=IXAg5I/voFOTN7UK8S1/VcNPL6kTPvvzVHgnkEK+6zOnHXlBH/NtgfT8oeoTDIJdEmXXSH
 vRz/v0yd+nt6AOabVjWbL2uS8zhVxWWS+mYFpVA00XqY1rZy5OZ2EZilcEBiA6xs4fwhNV
 /+M3wcTlMsCPLdjcy2Jyuq0rLz5hp14=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-vxNI--SiOPOStY-62onSBA-1; Fri, 26 May 2023 12:08:35 -0400
X-MC-Unique: vxNI--SiOPOStY-62onSBA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96fd6bd135dso114926866b.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117313; x=1687709313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sd3T10HXiJPTxzvEoZFcDCGXr7r+Y/M31alTpJVCV8w=;
 b=OWQXT3VBqzuoIIc7g9q17PqJyA4ow4Bkzg0Tcj1BBselpCD9+0CqiXC6HIJSjPB211
 VuN4RY19MbRZb4CA5H/ZiBeyGO784P2GczdowLu+p06bQ6adWIx99AHlw8WS9xIwitLR
 79qEAx2175ve35efGvxSJZYdAuOiuTKUxcWlGm6SlKgh+0cJgwG586564exLTlPxcB5k
 oKjZvQfFPqb63+LOFpFQ4gQs/AsLWcblO7ZT4zObaC4p11sJAApewsqSaBsprezLX0DE
 5iPKbQmspaYg2Lf4SJztjkI2l4YEpgD0V3AQGdcTmUhmz3S8f3ety++udsKcz1ma2H20
 Qr7g==
X-Gm-Message-State: AC+VfDyA6bI09JpGIODgXBMNuoCuUHaB6a84+KdD2XIO5uqgJPyVaIcB
 PgLkdkXMHLhGg0VdwZT0RRxIOt21PDFYW+jnYn0lStnpJU7EFG1hHx5AxFC9iyiAbuEe4oo8dMs
 40lYD9NMrNb37fgz/y2D4ABCsi/FbvuGueCifRmI5Nv7vrg0GyMBIA62ezshFVHZyiApQTNE0Qo
 Y=
X-Received: by 2002:a17:907:94c3:b0:94f:8aff:c8b3 with SMTP id
 dn3-20020a17090794c300b0094f8affc8b3mr2654506ejc.28.1685117313194; 
 Fri, 26 May 2023 09:08:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ujyTu1C/N0mQxwf8g6TvPwzPSsVdZCD5RLCZH6nS7TJ6K7GD9dYSXuaZpdWXPEZFHC6LcbA==
X-Received: by 2002:a17:907:94c3:b0:94f:8aff:c8b3 with SMTP id
 dn3-20020a17090794c300b0094f8affc8b3mr2654488ejc.28.1685117312972; 
 Fri, 26 May 2023 09:08:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 h26-20020a1709062dda00b00969f2d5267asm2326252eji.114.2023.05.26.09.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
	qemu-stable@nongnu.org
Subject: [PULL 04/12] configure: unset harmful environment variables
Date: Fri, 26 May 2023 18:08:16 +0200
Message-Id: <20230526160824.655279-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
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

Apart from CLICOLOR_FORCE and GREP_OPTIONS, there are other variables
that are listed in the Autoconf manual.  While Autoconf neutralizes them
very early, and assumes it does not (yet) run in a shell that has "unset",
QEMU assumes that the user invoked configure under a POSIX shell, and
therefore can simply use "unset" to clear them.

CDPATH is particularly nasty because it messes up "cd ... && pwd".

Reported-by: Juan Quintela <quintela@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 80ca1c922151..9cdce69b7852 100755
--- a/configure
+++ b/configure
@@ -4,9 +4,8 @@
 #
 
 # Unset some variables known to interfere with behavior of common tools,
-# just as autoconf does.
-CLICOLOR_FORCE= GREP_OPTIONS=
-unset CLICOLOR_FORCE GREP_OPTIONS
+# just as autoconf does.  Unlike autoconf, we assume that unset exists.
+unset CLICOLOR_FORCE GREP_OPTIONS BASH_ENV ENV MAIL MAILPATH CDPATH
 
 # Don't allow CCACHE, if present, to use cached results of compile tests!
 export CCACHE_RECACHE=yes
-- 
2.40.1


