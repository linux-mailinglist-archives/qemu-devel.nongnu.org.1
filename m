Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AED947F1F1E
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:22:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Bh0-0006EC-04; Mon, 20 Nov 2023 16:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5Bgs-0006Dq-B4
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:20:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5Bgq-0007pI-QR
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700515217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=fNvPPLoJxGVznUlOvSXX9ONeqsdKsKIhRnqFxHzimqyV4ZB3Z6XTWlgzsU//6dMg0zI1A3
 KahRSSAlPPcm7RLIEfru2TLsiHaWor3/GPOXlZYFX2tNJuURwwAxPaV6ZCHjPtFDRX5Z+D
 A3h10jaDfAWA/wy8X9jntyMaAnWB9hY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-KU8CqbErPPOLLMZ8HmryFg-1; Mon, 20 Nov 2023 16:20:15 -0500
X-MC-Unique: KU8CqbErPPOLLMZ8HmryFg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-54366567af4so6315247a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700515214; x=1701120014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=WR4wuqbIrHJQgT6NC7f/5dMQqYiHGXeGffBzmgy3Pw8EorLZ14BacTZStwsDZ4YkXA
 rL6O11UZGGVipu4MV3GRmqulZ6iZzBBmPukop8oT2gMSKLv+lo3YhMiQjK6zxXoy/+Dz
 WTp/LxMe7la+Et5kUIXAyTKUxfahOdK2qpgyZvRYkC0wE0yai7MKgj14FzMBYL/g90FQ
 8THA0XoWRduqXCoD2HB8DXg8qLyHQtSERGei/AjuOvEXzv5M/v7ZeEedEE/EJeBUZafk
 s14LIEqrbdMKAafpgZ80Yc01DAZNI0y5a5Pi9x9yMt/pTIFUe7RXbEjDTGOFnadi/65a
 evgg==
X-Gm-Message-State: AOJu0Yw40lW4vGbTHmW/WmfvQbQR2QUBS+F/RUKEEaB5Ea7dFcSj9uDW
 tF9sEEliOyFL0Iqt6RErfxyZPJ4f6AG52lWKcWpaXxg5m1pgivWxDtc7wCEDoRgGnYNAU/05LNI
 yPmG1AELoTgH93Sv99gmimsE=
X-Received: by 2002:aa7:c505:0:b0:548:ab2a:7508 with SMTP id
 o5-20020aa7c505000000b00548ab2a7508mr486350edq.10.1700515214095; 
 Mon, 20 Nov 2023 13:20:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4dtUbG80tMBk03JpkHtB2IC/Ml97u6DluCT4rI7mnD6uzXNihO0iGeK7xoKI799tU+kUtow==
X-Received: by 2002:aa7:c505:0:b0:548:ab2a:7508 with SMTP id
 o5-20020aa7c505000000b00548ab2a7508mr486340edq.10.1700515213780; 
 Mon, 20 Nov 2023 13:20:13 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 p1-20020aa7cc81000000b0052ff9bae873sm3929808edt.5.2023.11.20.13.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 13:20:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] audio: Free consumed default audio devices
Date: Mon, 20 Nov 2023 22:20:10 +0100
Message-ID: <20231120212010.49120-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120112804.9736-1-akihiko.odaki@daynix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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


