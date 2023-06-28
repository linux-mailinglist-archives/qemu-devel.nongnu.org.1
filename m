Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF91D741770
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 19:46:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEZEJ-0005Jf-NJ; Wed, 28 Jun 2023 13:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1qEZEF-0005JK-VL
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1qEZEE-0002QI-Jo
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 13:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687974317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oE0EzMLJw67tIokesO5Iyf8YddEQAkELQa2+UIHtkMU=;
 b=SBxyh4Otavyn2P12wkrZQwk7zxqSWfI1u6Akq+FXhYKUIH7hYOhGfHLWeL9PZxpCbe14Bx
 jb/I6YhOWCMgngynR704DAyeRNrMbAlZB3OCjmWF0okePw/zKvyO4ZuM5D7XZ1dbp0jSrn
 EkAxst1cUGjHOMbR0vrJvyL9puHahVM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-MzN167o1McGjwx2LrT2EEQ-1; Wed, 28 Jun 2023 13:45:13 -0400
X-MC-Unique: MzN167o1McGjwx2LrT2EEQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f7e4dc0fe5so860985e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 10:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687974312; x=1690566312;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oE0EzMLJw67tIokesO5Iyf8YddEQAkELQa2+UIHtkMU=;
 b=ZWhUgum4UL42CJgCheATZE81p5f2040zZg9dWDcuT9JgYA19IibW+gaK4ZqbDoCqNl
 6MnpjpsRkYwCa+qayoMh6QHr65hINxoxOvgjeQrAy1VJ4HTV9g0c/qey8JUZJHZf9lza
 ZJ8AzUZj4ZbuGgFdPqRUBmFKDSL0yIDnJzb36u+31+evqc8uOtiqxuMpvxgjBRtivjp6
 2qVrLzgIHOAfQI7j+4dHYh48EwK2kpuzlPE5pJEfIi2lBmWsdpuzWRDi8biUDc/ltWEr
 mq2q/vyeDBONy6/FuytQG8wLGJNaf66qppYhTX2O9zpmkWScYRW8QE52OHj299zW3Ep7
 yCkg==
X-Gm-Message-State: AC+VfDwOvyckap25UmmYXaQ58aW4uWSqnHNtV/z6x6SucJfB/ullWK9E
 X10Bfym6dNZU2LtrLdtlzsMwOY0MXNjex1SdESHGrsOUkuS2dP0cBNJ+6gM0P7PspgfltS/ql4S
 wLYEH/AqW84O/7DQ=
X-Received: by 2002:a1c:f317:0:b0:3f8:fc96:6bfd with SMTP id
 q23-20020a1cf317000000b003f8fc966bfdmr30105084wmq.17.1687974311878; 
 Wed, 28 Jun 2023 10:45:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7HK1I0GFfj3ngN7tGQpoO1jATuo62YMa44kMs68UTle73u3CWZB4HL2c8KVwFY7pfWTnpa+w==
X-Received: by 2002:a1c:f317:0:b0:3f8:fc96:6bfd with SMTP id
 q23-20020a1cf317000000b003f8fc966bfdmr30105074wmq.17.1687974311556; 
 Wed, 28 Jun 2023 10:45:11 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:40d:b941:c5de:c58f])
 by smtp.gmail.com with ESMTPSA id
 21-20020a05600c22d500b003f9cb3c8958sm17518939wmg.3.2023.06.28.10.45.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 10:45:11 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jun 2023 19:45:10 +0200
Message-Id: <CTOGYD8CO5Y9.1MECI0N7A3VT3@fedora>
Subject: Re: [PATCH] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: "Marcelo Tosatti" <mtosatti@redhat.com>
Cc: <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc/0.15.2-46-g263d8cbec504
References: <20230616140830.316655-1-aharivel@redhat.com>
 <ZJxtTCWvqO2VuL8q@tpad>
In-Reply-To: <ZJxtTCWvqO2VuL8q@tpad>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Marcelo Tosatti, Jun 28, 2023 at 19:26:

Hi Marcelo,

> On Fri, Jun 16, 2023 at 04:08:30PM +0200, Anthony Harivel wrote:
> This feature is activated with -accel kvm,rapl=3Dtrue.
>
>> I suppose this should be a CPU flag instead? -cpu xxx,rapl=3Don.

It's possible yes then I might need to make sure that '-accel=3Dkvm' is
selected because this rapl feature depends on the KVM msr filtering
mecanism.=20

Like '-cpu host' is checking that KVM or HVF is selected.

Thanks
Anthony


