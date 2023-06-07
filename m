Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FF4725950
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:04:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6p47-0001ka-Jy; Wed, 07 Jun 2023 05:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6p45-0001je-GX
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6p44-0008Db-6S
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686128567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=IGRbCMjcViaYSho53j/PRS8xcHaqtx3/WDkiZPGqToMVgDbb33FfKRoE1kziPyjt012cw0
 6WVrhAdyvlorI+STaZxRsXL9+obz4qw38jUtLHVZdJ8JQfU1s1WJgMKjWyW6v8Juc/3sGS
 qR2lz13rZHIK3SlE5T0D/8BRSkMiY8M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-vfnL8XR2MTG3rBs1nKKOKg-1; Wed, 07 Jun 2023 05:02:46 -0400
X-MC-Unique: vfnL8XR2MTG3rBs1nKKOKg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-514b05895f7so683093a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 02:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686128565; x=1688720565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=CpoKCB9mitodhfTaTDuSIR6F7kx4kcEFKuq+fkBhMlcvyZvfWgxWWE6FWtTScGlJtG
 hvsNavLnZPRl/DMjsHuH4t6kPq/T0BYhmdwDHSGeH1/KdiVcsKlpGMFpu5NnOzcoQSP9
 6FDymHytduA2IiCKksFpuiSHDGzgUzLhgKfNMChlWeIWkwZO2/tGpqEGSHDNiJeIiw97
 DrktwaOfYojAnCIPTusc/RtE0OYE6gD1TpGYUigknmx7KQsCMqkzNpMDS0g6mPrV/gRq
 5AREUgtuGYHgXR0K/WIOne/dD6nMVLi/eve4fewS3iKTJXoVLLai4ghwV6sxClplKnVh
 MHOw==
X-Gm-Message-State: AC+VfDxcSNbYG6PBtYzREB4jFb0HZTA70mOJdEZ7p0tY4S3zLbJcc/CY
 Ol1u+jbrVerzlRmJYlZC/3PLK9y3HYvGaTn+03dUtudgT0X4ZiiwpvG7l4LHelXzRMu+oP14lYc
 hjAo2emv0DpwURQTsBA6o0+g=
X-Received: by 2002:a17:907:a0c8:b0:96f:4225:9009 with SMTP id
 hw8-20020a170907a0c800b0096f42259009mr5551641ejc.0.1686128564916; 
 Wed, 07 Jun 2023 02:02:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7nzNDzHTaR8heq2rhLkDDve/7gq2VGEPyQj0LM2x6T0/6YKxwUwV9RIW2+zbg8RL0nnyyQXA==
X-Received: by 2002:a17:907:a0c8:b0:96f:4225:9009 with SMTP id
 hw8-20020a170907a0c800b0096f42259009mr5551625ejc.0.1686128564637; 
 Wed, 07 Jun 2023 02:02:44 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a170906350600b00970f0e2dab2sm6612620eja.112.2023.06.07.02.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 02:02:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org,
	pbonzini@redhat.com
Subject: Re: [PATCH] configure: check for $download value properly
Date: Wed,  7 Jun 2023 11:02:41 +0200
Message-Id: <20230607090242.59095-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3236bc555c76dcd561d38a3aea6e8489e917bc15.1686124161.git.mprivozn@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


