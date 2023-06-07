Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E755C726507
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vP8-0008Qm-U4; Wed, 07 Jun 2023 11:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6vP7-0008QQ-Gj
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6vP6-0003Ii-1W
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686152929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11XdTGsWxISKDjO5rEOLStvuEdXTin7k0QD+1NSzcAw=;
 b=DzTb/qekwYmL5iVrWx0dpMj3dnwjeUJhr1toAZ9o8wNJZDtqEDylq1Ce55psp7qa+OzEbV
 CQysuQLLuqv4Tppl9OdelCdizc6VKI84Tagdhh1HjmRB/pquOca6u/OtU+WZ801dDVZyt/
 FMk5lyQirLlQPAGEiz+HKhF68sGvFFU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-gCN2-4LwNZy4EnzOte1LcQ-1; Wed, 07 Jun 2023 11:47:47 -0400
X-MC-Unique: gCN2-4LwNZy4EnzOte1LcQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-514a6909c35so1133360a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686152847; x=1688744847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11XdTGsWxISKDjO5rEOLStvuEdXTin7k0QD+1NSzcAw=;
 b=SDjD9r0QhQVsJCfi2lf51paMppEFkQlzVdESitaccrVxYZdzAVMIQQcDw8wjH+C5Ic
 +3+3cSMpMzjYNTi62bQ3Oq4abvlAGYGUjchIHHCiLyRWkJdeK6ujPYHsMDY0Lw958Qf4
 LX+qI5/MTldIFj4nuQZgdb9xn0mwcTKQXz1rNd8FAnhZyn8UKg/F9yTEKqAOnrDj0vC+
 xuZYPDtp3Gs63ye6hlaNnH1X0eiJ3WvJcSsWiud6zkHnXp51K00qusc7KI2kveQJsuyI
 eL1/1nunbLHohl4q7thA/MjdPVKHA6arFcctwI/nixkpy7TLWdh+2OhS7f8jbXMx1y4M
 lVMg==
X-Gm-Message-State: AC+VfDztpjrhxuuDFpnxRiRTyIFux7xDNZ06CfxYuMar0NSjk4vUvT7P
 LAmOwH9jwRWMih8PRkuMeQWPjuvnlppudbRhiwdYXvtDDaC18ybyp8P9dtBvjzDKjtl6FdiPv8a
 pAuS1/HnGH5t2jAarl7k5sKLvvkYfOHr1lq4SCtcP1e5U75SVyWXwUj83gEMSNJBwg6uU4Ycdwd
 8=
X-Received: by 2002:a05:6402:31e5:b0:514:9422:37dc with SMTP id
 dy5-20020a05640231e500b00514942237dcmr4538417edb.6.1686152847506; 
 Wed, 07 Jun 2023 08:47:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qGnt9aPhpLy2XC/xV9R/NqzU4Z23BdPO0trtyD9BdgijGdm3e93xv6ZlX7mAMfYlwhWkTxA==
X-Received: by 2002:a05:6402:31e5:b0:514:9422:37dc with SMTP id
 dy5-20020a05640231e500b00514942237dcmr4538400edb.6.1686152847171; 
 Wed, 07 Jun 2023 08:47:27 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa7c95a000000b00514bddcb87csm6396403edt.31.2023.06.07.08.47.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:47:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] meson: fix "static build" entry in summary
Date: Wed,  7 Jun 2023 17:47:22 +0200
Message-Id: <20230607154724.253659-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607154724.253659-1-pbonzini@redhat.com>
References: <20230607154724.253659-1-pbonzini@redhat.com>
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

Fixes: a0cbd2e8496 ("meson: use prefer_static option", 2023-05-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 553c8e0b9c5..c03326c922e 100644
--- a/meson.build
+++ b/meson.build
@@ -4088,7 +4088,7 @@ summary_info += {'QEMU_LDFLAGS':      ' '.join(qemu_ldflags)}
 summary_info += {'profiler':          get_option('profiler')}
 summary_info += {'link-time optimization (LTO)': get_option('b_lto')}
 summary_info += {'PIE':               get_option('b_pie')}
-summary_info += {'static build':      config_host.has_key('CONFIG_STATIC')}
+summary_info += {'static build':      get_option('prefer_static')}
 summary_info += {'malloc trim support': has_malloc_trim}
 summary_info += {'membarrier':        have_membarrier}
 summary_info += {'debug graph lock':  get_option('debug_graph_lock')}
-- 
2.40.1


