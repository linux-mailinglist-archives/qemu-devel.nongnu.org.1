Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E8C70C484
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 19:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19Yb-0003Ve-GM; Mon, 22 May 2023 13:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19YT-0003V7-C9
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q19YJ-00048T-GC
 for qemu-devel@nongnu.org; Mon, 22 May 2023 13:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684777351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AI2qD0dkVN6KqlZcgbm1QUkyTWFMo/jCeG3d40Z+YVs=;
 b=QjevjIPJF+wJ8sxJKVen6c1+47SNVu2d2LbjuguVUYJRFfQ8y/mpSNiZFHryn25dPO+twq
 cH03CWM0yHF+7CNXJB+Wn6uULkDJ/U8rsoKH/nFfw9yp7tm0HH4G2e7CPZo/92jSs4tR+T
 i8bHo9w1rc9NJDxQ06/lr5dzrB18NTI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-cU8eVQRiOAKavdIxP-ANpA-1; Mon, 22 May 2023 13:42:28 -0400
X-MC-Unique: cU8eVQRiOAKavdIxP-ANpA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5ff240197so8578555e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 10:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684777347; x=1687369347;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AI2qD0dkVN6KqlZcgbm1QUkyTWFMo/jCeG3d40Z+YVs=;
 b=Jcv45cvHMZJYQLoypMDhy2I0OYV4KsQ5TUhhww5eaHsAcaa4DQ9a+VRr5r67nWbxHm
 tJpScEdrAlgRKy+1qiWybgj/DwQH/MttdHwSg/1cE27zWYCSdFZNuEQG40yi8Pdyyrx9
 c3PcoNJEo/ZfPVnIePnxos3dMWmTURjjCXfj3y5cDTiszEUo1PiumySB/BfZawtYNV93
 +WGY0x3wQCN810uppi/OSZR4N+6m0Pgi59fIenrJmQmMzRZkK+1eQLuPZG7hS4nXzapY
 kGE91mlbeHKoONEsu62yjCwx2KOkUq1qslGQb9A9GJefuCUoH5Hny9kY1z1Wf2LiwiW0
 RmhQ==
X-Gm-Message-State: AC+VfDwVRzAVvko4FBO5u7gZVheeVJxTNu/7N2MCkd0PlKHXNLm2AH/q
 /4y20n2RzXpsXdzlGBgYDVteBZhWJEPYy1trqm5MwyELUdFD7XINpjFJtZWlA1RqOb2f9dHfkkg
 vHMdGZBMH2iNxGM5CIHeka8koMGG3HRvOmtdU404UDdyQlaj3ITaUlu/fnR8+QyP2aw2pwE8h
X-Received: by 2002:a7b:c4c8:0:b0:3f6:552:8722 with SMTP id
 g8-20020a7bc4c8000000b003f605528722mr1833609wmk.18.1684777347099; 
 Mon, 22 May 2023 10:42:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4siZS4hkdAbjnA436CQCl5IFs97g/nU+av+5dR8jg1pxxDEIgHn0PyrtgH3HTyYHfAvouBzQ==
X-Received: by 2002:a7b:c4c8:0:b0:3f6:552:8722 with SMTP id
 g8-20020a7bc4c8000000b003f605528722mr1833597wmk.18.1684777346721; 
 Mon, 22 May 2023 10:42:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a7bc047000000b003f3157988f8sm9030805wmc.26.2023.05.22.10.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 10:42:26 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	thuth@redhat.com
Subject: Add CI configuration for Kubernetes 
Date: Mon, 22 May 2023 18:41:49 +0100
Message-Id: <20230522174153.46801-1-cconte@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cconte@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SCC_BODY_URI_ONLY=1.17,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Here's a second version (v2) of patches to support the Kubernetes runner for Gitlab CI.
You can find the v1 thread here: https://lore.kernel.org/qemu-devel/20230407145252.32955-1-cconte@redhat.com/.



