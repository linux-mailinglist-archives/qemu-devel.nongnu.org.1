Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F084B7245B3
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:22:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XZF-00080t-Ul; Tue, 06 Jun 2023 10:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6XZD-00080Q-Oo
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:21:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6XZC-0007eu-9Z
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=M5x8wZEULyIGlbWTol+fiZAQBHG2XjgvAOCKiLQd+L2ocKK7qAH4BsDreatzAIhnHCCQKs
 SvZR0ghL8XxFQ+lRnm5yVi1Mtr4lxGF0LGsOGMwoxg7Cn5uNqZaVHWlDAIPfSM+INCZDNp
 OkQTiLhn6eQqkaKKDo3clfIbkYYJJLA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-3XgGnisxMc-kHIbKuD_x7Q-1; Tue, 06 Jun 2023 10:21:40 -0400
X-MC-Unique: 3XgGnisxMc-kHIbKuD_x7Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4edc7406cbaso4037519e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061299; x=1688653299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=U3ydLzi/wwp9aUhtDFStkMF8cDNB/jYUEIYqYytjp81Mtfbcwdhq6nmwEREHFpsKmy
 nJwsvxPi3KPm1UiiwwGbTUqlzhs23wujYoNpvGcm7yB0L37MWna76hCNkw1lObLfAIAC
 Rl7Yobmd3pLYynHkMGiBWEJCCEO6+f7nfsrXxpfu7p+nWsb+69TpgyM0A5XIl1QjarnT
 sd/1iE2vF4sqAA31P3jtzbbHo1Zc/7x8MDYW++/tx1gAIP3tJbIEL+1sE/x6L3b8F/6z
 tJYuyEfk8albx8V4CelhkCkfSkGDFDuNHZdO/xExtgyy7IP3zaIfda3Wy76ybqmXgKIc
 Vutg==
X-Gm-Message-State: AC+VfDxkTRBWj2/GYRrWlRFrYeD0qM24GtnbDAY8nKSCnWLxlZYLm34k
 NKFEgOFIExrqWcDriXrLuI0ht4TMm21P0oa3h618y4tBqLFKvVW8V7dVxxPN+qEnXQ8ukbiqtOv
 5pD8EcZxMJbtWxDo=
X-Received: by 2002:ac2:5dee:0:b0:4f6:170f:ccbf with SMTP id
 z14-20020ac25dee000000b004f6170fccbfmr1093141lfq.0.1686061299188; 
 Tue, 06 Jun 2023 07:21:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7n0OB97Kf8DZrBFNHiR7a7+5rwdnyIJfheRHESbpIyoQ2bBVMS4rntnsZAjZy5nAlVNbSd2g==
X-Received: by 2002:ac2:5dee:0:b0:4f6:170f:ccbf with SMTP id
 z14-20020ac25dee000000b004f6170fccbfmr1093134lfq.0.1686061298872; 
 Tue, 06 Jun 2023 07:21:38 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 r25-20020aa7cb99000000b00506987c5c71sm5075363edt.70.2023.06.06.07.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:21:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>
Subject: Re: [PATCH] hw/remote/proxy: Remove dubious 'event_notifier-posix.c'
 include
Date: Tue,  6 Jun 2023 15:59:14 +0200
Message-Id: <20230606135914.664277-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606134913.93724-1-philmd@linaro.org>
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
 TVD_SPACE_RATIO=0.001,
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


