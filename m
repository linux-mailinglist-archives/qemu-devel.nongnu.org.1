Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB96704F7C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyutg-0007bT-Ce; Tue, 16 May 2023 09:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1pyutQ-0007X0-BL
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:39:10 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1pyutJ-0001P0-Na
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:39:04 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-55a10577911so199313447b3.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684244340; x=1686836340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CllLkHH9p6gGW0hGbjVctL1o9IqvWMoQKcuYgYXGX+k=;
 b=mpoHVI/fT3KYG/IRsPZakofHeyLg+54wIrCQEsG8QQKN9oTWwq/7Q0tsJ9UxLBePsR
 TtmJxwJqhYhynlnhLCrr7BDwvaaFhOHzTeuxYXFwfc4g9Ndvx0GpKsUjJZx+KbOnziCo
 ypkxTTZSpni0FdDyafPk/xz8T7G9aphQ5SiuWnPXjQTVk2+Hr1HAINnrpcJI+M3pAPXJ
 bjgWJN6mAkX3CxASae7uVNwQRAZQZQ7T5vEk7jqJ2WHHarxYW8t8h41RKVyAvXgk89pg
 +yWlGBZwVWm+txjHnJqMQFNJsmZGA6MbBdM8ChKddUTsvVv0ryLBHMonQ08Yw/tQgoAX
 ebiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684244340; x=1686836340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CllLkHH9p6gGW0hGbjVctL1o9IqvWMoQKcuYgYXGX+k=;
 b=jV70AQgtCxdDQiNwVLjy3ABtihPqQ07tebmvk1NBUIx7oK3Pwy1vNbuWWY3MdM9qMs
 akWLDv7v0XGB10DI/v9yk7FP0Ejz8U4NzkerLglpmet37lbvwSaKprZpr61gZSIGO6wP
 HCguhu1mo258sKmX/u8jXe+BG71wis48hRO80iy5OMvGLSwzXVihvHZOwPTC+DwPx4dt
 tXK21kduBnIV9360Meyh57OIBCnFQ0pROqjzNyDjJC/X1IQT3V/JcxZ3rmnKk9i8s+2S
 FVh2eGZWJ8LEDGSqF+pzJCM2d9Pul3UIJSWO9PGVxV7Q5Rt2kmX9vc7IKisyaNFMHjDI
 hJWQ==
X-Gm-Message-State: AC+VfDx9ADa1HaxWJ+23OaLlCthR5rcuxyZBBiPUT1lMdhsAKKLCyL+e
 KDbhdoTkz7SL7vaKS3EPJvhQDxCRFHI3D8N8qwvultJP
X-Google-Smtp-Source: ACHHUZ64F/yZzqUgTUeKrMhaJWRQx7zYi81wkFEO98SYKK7jEmuZzqG/7+y5OJX81C5uPYEct7fP8fbChIJcU+HlKoo=
X-Received: by 2002:a0d:c205:0:b0:561:508b:b8f8 with SMTP id
 e5-20020a0dc205000000b00561508bb8f8mr5731491ywd.50.1684244340439; Tue, 16 May
 2023 06:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <a3fda4a6-412f-8230-3455-f8d2c34637a2@redhat.com>
 <CAJSP0QU5TcbpvHPF5yH2pAn=rPmKzZPZaeR855u+F3jVYgA0mg@mail.gmail.com>
 <9de16378-05d7-3144-216e-97223b058666@redhat.com>
In-Reply-To: <9de16378-05d7-3144-216e-97223b058666@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 16 May 2023 09:38:48 -0400
Message-ID: <CAJSP0QXcu_dztBZ-pp-v6TZcUGo3ZewEHvHoe9asChiXrb7_Yg@mail.gmail.com>
Subject: Re: Performance improvement with
 58a2e3f5c37be02dac3086b81bdda9414b931edf
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Thanks!

Stefan

