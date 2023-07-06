Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 158DF749F47
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 16:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHQDK-00057F-5V; Thu, 06 Jul 2023 10:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHQDF-00053l-9n
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHQDC-0006kc-7U
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688654641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Pm6mqBh5kmoAUHV4uxK26oX8KrsO7zSPvnvxkgHWe8tdY8YYyeCKXDTyETM8t61B9sAS6D
 p1TgHvWXSz+PODU5zrdR15Iv2Sk1Di/to0QZI4qIk4jY04s9f6Q8Yd/+gmVxVUFExRK9Pa
 M5hN2fNslHDipFxIfVf/eYKyqlPdsmQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-hM1wcoLEMBiBu0uEuSQl8w-1; Thu, 06 Jul 2023 10:44:00 -0400
X-MC-Unique: hM1wcoLEMBiBu0uEuSQl8w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-987e47d2e81so61260266b.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 07:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688654638; x=1691246638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=T8XudZeLHpdZBNcVih9NuePoX/EP1wosGrroKMIFfj9TCHGPzSzZUjdEKMdCxgORWx
 p3tGprFYH3xtIVHO6uUtrMFYZqmrxKrwaSbS1fGKqB+nxl7IzpMHJ6rOxgMwc9pcP9Qy
 yrYrV7nCCGa02sL+aTTF1Bodh3BJlj7+Fh3l0WswaPOeGk7CTSzyT1ZP3m54y/mTflWL
 QDXUsfv8gzckopUrmK4g/x1p4n7udfoXM20UJtv9qGtyv/676L0OQf/5lqMHrquLjeqU
 4akCrWNkqeniHsxwFPU8e5wgHJ6TA+cT9v+OujJ8FKPsdGpnjy9mDiAeTw2iRDsUsCcB
 Gcmw==
X-Gm-Message-State: ABy/qLaM81mHcNhgMCibT0KOFkJ3cmXQOnJatDaRlJSzF6JVYYZ5HmuI
 O6F4w5+KlBTrQ/Afz/xHkz0+qxX+PR2g/h90BPaFI6rFpgeRjVd32wE0p6MWmHcsBI1t8oHP3jp
 Eg0SqQw4OokldJfd4Ot7b+AM=
X-Received: by 2002:a17:906:27da:b0:97d:ee91:df83 with SMTP id
 k26-20020a17090627da00b0097dee91df83mr1460218ejc.61.1688654638666; 
 Thu, 06 Jul 2023 07:43:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG3hHVFIlPwDNGdJuNFGykgOT/duxVBgs4n40dHWSs0z3LlMWEdbew/7SuuFIKtLXc/qDntoA==
X-Received: by 2002:a17:906:27da:b0:97d:ee91:df83 with SMTP id
 k26-20020a17090627da00b0097dee91df83mr1460208ejc.61.1688654638429; 
 Thu, 06 Jul 2023 07:43:58 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 kg8-20020a17090776e800b00992d8aa60b0sm911897ejc.63.2023.07.06.07.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 07:43:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 t.lamprecht@proxmox.com, qemu-stable@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com
Subject: Re: [PATCH] qemu_cleanup: begin drained section after vm_shutdown()
Date: Thu,  6 Jul 2023 16:43:56 +0200
Message-ID: <20230706144356.16209-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706131418.423713-1-f.ebner@proxmox.com>
References: 
MIME-Version: 1.0
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


