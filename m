Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476A281F7C7
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 12:35:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIoeG-0007Fa-Lw; Thu, 28 Dec 2023 06:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rIoeE-0007Eb-NQ
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 06:33:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rIoeA-0005na-TU
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 06:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703763232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8dmv7B+f/LNN1Mc9HwhJHdok+La6jmgSbKo9CviWX8=;
 b=ANnLdYLHig6csUOMxCHfyvxV0R8Shnzuw4iI7r9WLHlhRtt/GSsnTcOFe4NYsIuDvul8q6
 Zcb1wbsaqwIgzHwIYtR4sOGPWtf4asvKzIsnmsX7Buq0wwr+S40V9gcoZg6YfKU7kdqK4T
 BscP0nqCVzEtMlw7MqySJRHdCG0QWNo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-kme0G9B1PVquxEzR93RHlA-1; Thu, 28 Dec 2023 06:33:51 -0500
X-MC-Unique: kme0G9B1PVquxEzR93RHlA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a23365478e5so334832166b.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 03:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703763230; x=1704368030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8dmv7B+f/LNN1Mc9HwhJHdok+La6jmgSbKo9CviWX8=;
 b=BDM0oIeJN7HF+n2UXkxI7TxcsUdLOdEZP0XJFhOV4+/j0gPk1+cURWZzB1v0Wn5lpQ
 fZPqHnI8LiOGUK4xfXGE+mQUq0GIDLuoodEliCB0xkgEX03LG2JKDHC22l5S0q7gjwMg
 TeOaPApUtNCHbWXXM+WabJ/cjXoamogcCBv0S6ahT2n66JfaLf15UOBOqtlST/Cw3auJ
 b+HxaY9mHsD95DIchtU6Qa/lrML4usnhLb8LdR4ZORn1IbST8h2xl8hN62HIrpJ08PON
 NQKz9p5J9+Yxk3CA55sig2nk8exngnuO8Q/gJ/2sfOumRRSaNd2mBkuOsf7b2KXEITUQ
 DhAg==
X-Gm-Message-State: AOJu0YwXRq4+2BdSzKlaUK3eF6TKCfIFtv41INzaglYIq+9TM4kB7hYt
 XFz6blYnsmtnlKVPHbykVd7wNNb3MpMTdP/l6EMNlsTF4vFc0V4Q96SGF97/rkp5p12U0t0TpED
 Z307CXLVsEYUPmTffLcS4FjA=
X-Received: by 2002:a17:907:6e90:b0:a23:482:ee74 with SMTP id
 sh16-20020a1709076e9000b00a230482ee74mr6234997ejc.28.1703763230259; 
 Thu, 28 Dec 2023 03:33:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQMmKo8HWwtqKc5ArtmNGRXjx08f9pPHh99HgO/Fs/XvOD4L4b8EkK9ulTVDfTqhe1WOohQw==
X-Received: by 2002:a17:907:6e90:b0:a23:482:ee74 with SMTP id
 sh16-20020a1709076e9000b00a230482ee74mr6234991ejc.28.1703763230004; 
 Thu, 28 Dec 2023 03:33:50 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 eu18-20020a170907299200b00a26e53be089sm4114850ejc.44.2023.12.28.03.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 03:33:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] meson.build: report graphics backends
Date: Thu, 28 Dec 2023 12:33:35 +0100
Message-ID: <20231228113335.63354-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222114846.2850741-1-alex.bennee@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.755,
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

Queued with the duplication removed, thanks.

Paolo


