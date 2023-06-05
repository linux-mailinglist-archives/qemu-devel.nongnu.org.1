Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B15722101
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:28:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q65ZH-0005AY-6s; Mon, 05 Jun 2023 04:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q65ZE-00059h-AN
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q65ZC-00073a-TB
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685953674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=VrBvoOkedyv4eukeaF+iEWDCUoaYuog+uC1FaCRTWlwYogWaaOzefI/TgluPu/ykrJzjkb
 RdzPUoJ4/LDR+kMd5GRTvu6SUP2YILFo2mqbr39MKIp2xP8Q7eOL8nfKHAdlhcqkapwv6z
 HKZJ4/uI+DXNnkiQMpT5x4NTFWgiYFc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-P__8XwLOP0ar0DqguC14qw-1; Mon, 05 Jun 2023 04:27:52 -0400
X-MC-Unique: P__8XwLOP0ar0DqguC14qw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a355c9028so332623266b.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 01:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685953671; x=1688545671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DJ90OX7gfDwO8ny7C5zUr8FoklBd4ZaizJZuP8k+bmpl9cymn7jc/PyKmFuqcJ6Sd+
 rKOUdf3xHTK5Lv10JEJG0TRIR0jHter/Sa237k2rt/UkjLCMPael6Gfh0TFUyG3bAZqI
 eI48Pe0nMxGnt3I9HlbhsKE4zZ001q6jRoqJbOvJyseN12gyZdpo24PhPiQMAK0yHBow
 o7475NVqdeFN9r5qRc1y6GTL8XNL9vKHJdbZSiXc1KMb7G81gi5riX7Z3aDjrpIZEKat
 FqHwerCeiBDHVoyITnY2YxkAapbR5FZIrO+Ck1BadPzWxxi5QOYw0OOQc7gIcMVSJjyP
 caEQ==
X-Gm-Message-State: AC+VfDyfpgA4ThNNmWcC041xOFSpaC6GWPi+NGtfgzdXl1skBhYBwX4q
 9XtAqamunCZ86yRpHlgqN5jfzwt816RR7jTPgtnrc7I8Cj8xSVJpV6GK8cimPl/OtNZ9IRjjnyP
 ICGAHUMcU3mE0mmYnyzS3er8=
X-Received: by 2002:a17:907:1c15:b0:977:e7ae:4ce8 with SMTP id
 nc21-20020a1709071c1500b00977e7ae4ce8mr796035ejc.39.1685953671356; 
 Mon, 05 Jun 2023 01:27:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uAlhOy85eKiCSPacjp+IaqInqbbgYx9nQW8rSY0cblh5p5aI3+Du1WwPqI05NE5ZIQHSC7Q==
X-Received: by 2002:a17:907:1c15:b0:977:e7ae:4ce8 with SMTP id
 nc21-20020a1709071c1500b00977e7ae4ce8mr796028ejc.39.1685953671212; 
 Mon, 05 Jun 2023 01:27:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a170906154f00b0094bb4c75695sm3990840ejd.194.2023.06.05.01.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 01:27:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH v2] meson.build: Use -Wno-undef only for SDL2 versions
 that need it
Date: Mon,  5 Jun 2023 10:27:48 +0200
Message-Id: <20230605082748.53989-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602163452.521305-1-thuth@redhat.com>
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

Queued, thanks.

Paolo


