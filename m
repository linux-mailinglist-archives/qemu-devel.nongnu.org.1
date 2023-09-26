Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FC97AEFC2
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:32:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlA2T-0007xo-Uc; Tue, 26 Sep 2023 11:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlA2O-0007tF-Qx
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlA2D-00018s-Fn
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695742296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+KNkd7GRWfE9FEkHgU5kKkyUM9laQoWonAMj4gVD+U=;
 b=DykJDGMVpMeN4dUhkH9bawIFYzcAAlLZaChxaEcWI76M5HeHBcQOnl5HMBLTKy9E7lRftr
 vikyNgqTQVzpkCRvXNC6umC2jwAMBWI1JpBBIwiAiCDXx5pnsGa2JbH8+DQH0tep3Rw8WK
 jojHNKrc64JGLUp84gRKFE5wmjq+EJM=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-S3Maae8PNMS8N24G7o6MVQ-1; Tue, 26 Sep 2023 11:31:34 -0400
X-MC-Unique: S3Maae8PNMS8N24G7o6MVQ-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7a01ecba96fso4534320241.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695742292; x=1696347092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+KNkd7GRWfE9FEkHgU5kKkyUM9laQoWonAMj4gVD+U=;
 b=H1zEam7N03ehFOmZwqQ5sA0mf+JAse1UPI4V6EHlGZXl4TtudEwUXn1/Gy/sCXqyQ4
 1xEEmy78HWCJ6c2RAqSfrhO4EQll2T/EomPxTYw0MLripBF3zGrP83bxhem8SAFaSWNH
 HSvtFCDLmVNbZxD92SauGfhF0aT722FMFZ2qKma/vBmnVsZVjc58f1DjViRFzMq+ZiD9
 9P0s1gr8Iww4lJbff8AHkeBZQijWTti+28pRfXSnVcJnhGpGKdHcqpd9SIoJW0i2mD3i
 B56IXMeHainYdcl/h+QzzKRX/T9MnhuChawNrBPrHtYIKhKblbrbcE5TU83Q3TFOi63P
 GwfA==
X-Gm-Message-State: AOJu0Yy+M8vlzWymlThRMOPh77N6zYt2jX+gGZa3Y5TmxU33z47Sc9GM
 2TIeYdxBT1rB1YcFviV1y7Rjzp7Jd9wSfJrxbKNnaRTCkcFr1CX18M3DPEtuqno6qKmzcsAM80p
 Z89KxWKC/lQTULQrT8mvNJmL54HEURw2xFgSUVYo=
X-Received: by 2002:a05:6102:34c3:b0:44e:94b3:9253 with SMTP id
 a3-20020a05610234c300b0044e94b39253mr7081771vst.12.1695742292598; 
 Tue, 26 Sep 2023 08:31:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU6kUpvWcRA/gjWOFMUcVyzfb6M94FkBqGLeEnRywtzNElneEelWc8MtKSk6KQXe0cTxv1v8YX/4S4SM2Y3aA=
X-Received: by 2002:a05:6102:34c3:b0:44e:94b3:9253 with SMTP id
 a3-20020a05610234c300b0044e94b39253mr7081753vst.12.1695742292350; Tue, 26 Sep
 2023 08:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230904100306.156197-1-pbonzini@redhat.com>
In-Reply-To: <20230904100306.156197-1-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 Sep 2023 17:31:21 +0200
Message-ID: <CABgObfa0XWeVmnNLtP4TFg1AWDjqJY52QuKQW8p-sc3dgRDqkA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] block: clean up coroutine versions of
 bdrv_{is_allocated, block_status}*
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 4, 2023 at 12:03=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Provide coroutine versions of bdrv_is_allocated* and bdrv_block_status*,
> since the underlying BlockDriver API is coroutine-based, and use
> automatically-generated wrappers for the "mixed" versions.
>
> v2->v3: cleaned up formatting

Ping.

Paolo


