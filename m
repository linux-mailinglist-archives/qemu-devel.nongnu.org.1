Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFA79031F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 23:46:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcBwn-0008GU-GE; Fri, 01 Sep 2023 17:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcBwl-0008GK-6X
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 17:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcBwj-0001r0-4O
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 17:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693604691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GDotBOwJKZa0nRhn/nLtMW4QRHv9uzVOasCRa38G1aiEdajbuZUq4iZ8vaZOzi/ervemtU
 l7yJtv/XQrp830aVPGEPPn78oKHFfP5KpsuykbIKFLT0u+e2r8ZuyULumbXi48WchQofQh
 TFl/RYqUHFFQVNjEPixljO1sWwYCk04=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-Hvqr50XsMKKHI0Y1AeuHaQ-1; Fri, 01 Sep 2023 17:44:49 -0400
X-MC-Unique: Hvqr50XsMKKHI0Y1AeuHaQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31c5cc3b512so1390397f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 14:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693604688; x=1694209488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Fr7e9q2Dym71Q53UV45R2FquW8qBpUMRGgj/QF4AFWN31k8Mo8UwmnO/kJP39ngQmI
 H7TMTTwqzujumJgvIP57dY/Ai/KqE71QYHIXLbO7REExSC/y0oRTg6TppuFTV72vEL3h
 0AcgsU1fT5YWOLT63Bq7RG13614Fp3zHH4Tr616GXTO+0qOV5jRPeav2B/2U1neES80H
 tNmttpNh3Lqy6pUPWpGsKsNmLBJWBZGvwe9PE52u8nUob/trXYTbY0+ZtX2gNYgaSKFO
 GAzXNiz46zqbfJQy4yIYnhupnTBLZ/qjbYGPyFnte7POjTyBs0Mmg2+yBCeKMV5WHXSD
 Dv/g==
X-Gm-Message-State: AOJu0Yy8b7vd8mJz6mAXxgrewI3vQyxaKU2DKIz0CMaFYeBA73ZUu0Ly
 0OuzuFOhI6gCXVqiPskh6aUsCTKdqMvjFzu5RHENaLDyTD+bzjEpj8/vB8Dol0EcjpPFoTHSTEO
 D2qgx8UdA2wVHp51w751pet8=
X-Received: by 2002:a5d:5081:0:b0:317:7af4:5294 with SMTP id
 a1-20020a5d5081000000b003177af45294mr2700193wrt.44.1693604688534; 
 Fri, 01 Sep 2023 14:44:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2C6SS9a/QFc7thha9o8++Zg+n4IGQWbkxuQ4UU+khltBEPbxLPGew+b50t3L1yLUGjM0WJA==
X-Received: by 2002:a5d:5081:0:b0:317:7af4:5294 with SMTP id
 a1-20020a5d5081000000b003177af45294mr2700184wrt.44.1693604688137; 
 Fri, 01 Sep 2023 14:44:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 k1-20020adff5c1000000b0031ad5a54bedsm6402436wrp.9.2023.09.01.14.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 14:44:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/8] move softmmu options processing from os-posix.c to
 vl.c
Date: Fri,  1 Sep 2023 23:44:42 +0200
Message-ID: <20230901214442.83554-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901101302.3618955-1-mjt@tls.msk.ru>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


