Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FFD753D5D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 16:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKJmT-0006EZ-8L; Fri, 14 Jul 2023 10:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKJmN-0006AN-L2
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 10:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKJmM-0005cd-BR
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 10:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689344896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Gq3gwKU+3SY+6AxYsNK6Ysz9vMG+sLVLNETgXCcQJca7ZbRb5FziwzCZus+A4EtDD8hdeG
 JSrGQsEpCXck+9SsbPs8qw2UrbmZtuudMW212FwuvXVyGzvNl58q6AZiCCstI0Go/6CUme
 ZaQ70k1DeFaOFsINjtTT3pZv3p5JQqc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-M5M9yOFrPfmeLJ-2Go_9Kg-1; Fri, 14 Jul 2023 10:28:15 -0400
X-MC-Unique: M5M9yOFrPfmeLJ-2Go_9Kg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fa8cd898e0so11972555e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 07:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689344894; x=1691936894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=NjhiQv1Z+OvWvrKVjOpdQ7qnSk7V/po5GDQ1hSNZ6UMOV+UifPIjqOR8t2qQM2R7ju
 kOlv6s0WFxbeJim546xA6pWMcrpjC9dPDixb5qUzXrS7sUeCfJoWcKfJlU+PYfxtag2q
 OajDizddKyVSJJ7VngHtxWa5Pm8in6pHcowvTkcrVfGi+YoaMx4cVBOf0JdO6Mil7e6Q
 yP/47ALirCTUehx1i1V3knheXawtDyLDMpG/Kmr1oKVle3etIQsJmReW3J70YdZQ7HgV
 9CMK3Z34Q/dX75sFZlthLLZII8jBF4mIAxIoYN1/FBdaYkIXE2vicvFMM4IwD9ZrJrhE
 9ROA==
X-Gm-Message-State: ABy/qLaDesXX76LIOb/Mez7DhhR0pSPgcJhg1tJdx5t5I3Rm7XG43c7C
 SKtmvqX0Z5ZuRQBpaSr6kbpAAtC9tFfo6UU79QgyhJqXy2LzrK6B0YWu1BAFo8J/zErdSyN4sZz
 cDo0O2nrKYyVUQCA=
X-Received: by 2002:a05:600c:21c1:b0:3fa:8fc2:3969 with SMTP id
 x1-20020a05600c21c100b003fa8fc23969mr4035033wmj.17.1689344894549; 
 Fri, 14 Jul 2023 07:28:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFO02HLHXOu4FQo3HFyjQ9OvKayJ83rwLDizUWL6lDXoeVTg09UmG76US9kJCiUQ46m1y+wHQ==
X-Received: by 2002:a05:600c:21c1:b0:3fa:8fc2:3969 with SMTP id
 x1-20020a05600c21c100b003fa8fc23969mr4035024wmj.17.1689344894287; 
 Fri, 14 Jul 2023 07:28:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003fbc681c8d1sm1553556wml.36.2023.07.14.07.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 07:28:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Matt Borgerson <contact@mborgerson.com>
Cc: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Subject: Re: [PATCH] target/i386: Check CR0.TS before enter_mmx
Date: Fri, 14 Jul 2023 16:28:12 +0200
Message-ID: <20230714142812.244646-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CADc=-s5F10muEhLs4f3mxqsEPAHWj0XFfOC2sfFMVHrk9fcpMg@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Queued, thanks.

Paolo


