Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 686BD78E7CC
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:21:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcv5-0002Yq-9Y; Thu, 31 Aug 2023 04:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qbcv0-0002JM-PO
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qbcux-0007eh-Nb
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693470040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1u+J20YHzf4b2c5/Fp361NJVEfr3vkFj7gG6k+DLQM=;
 b=ixPOTZfHPNZi0JBF96nVBTe1zZ0SAbdtYJK5XwiojoT+KcKrkTl74P8TsEvwzdkEhWfBGF
 o2hMzzq1zQatDKdu7o0B9yjyMwvDXcTRBRingo+7xYGXhayJqS8o5vnl92U7Gs7Ybgr+Uk
 XNRwlFeqe3ErlM/oVfUYNuhwWUdvNgA=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Kqm2A20xPB6Q9jkQ3WbTTg-1; Thu, 31 Aug 2023 04:20:39 -0400
X-MC-Unique: Kqm2A20xPB6Q9jkQ3WbTTg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-44d4bd0bd67so319341137.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693470038; x=1694074838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1u+J20YHzf4b2c5/Fp361NJVEfr3vkFj7gG6k+DLQM=;
 b=bA2b/gITs81TQP1mvLJWkNHXrwWGls3mYfoQUO5rRYoT2iYu6JmYuvDcuuKV7A3z/4
 dkm4N5odm97l4bvBZeqoKkNE0QVK5EvSZUuv9LMo+F4WXVvPd7Fcupdg7FvKTMETP+ta
 HxpwAFArf7h7uEZzOKdMS+Wf/pgMZB3UtihnI5M+mlz8jnV7Eo0H7JWVDT/yZPpB9CxT
 b+5idloj5SedLfQWPLL6gFuQWIdYCoGcG6i26MwIEicI2nosqFRvbrVPZA7pA2TwL1lf
 Tmcl6Mn1liNW1fNJvVzPPqk0VqxSNxEqQ7kqEGVsV2QPmAncPjxEoK7FonFeU5avKWSM
 SpyQ==
X-Gm-Message-State: AOJu0Yz4AaFRg6+J3OsVSzuyJJmt1Qt3FPoGLB/EdrcRdkIfBaAiRBYx
 b5Vhy/W4LTbiw22NKtV0z+iUXPpx0KWQmQWJIWsC31G1yIM0VN8wGqa+XTzr+Bkt4MNdpwFDE/0
 YH3NUWDnBVFNwPsdsXQxLFOBd27uP2ps=
X-Received: by 2002:a67:fc0b:0:b0:440:a8c8:f34 with SMTP id
 o11-20020a67fc0b000000b00440a8c80f34mr4587379vsq.3.1693470038418; 
 Thu, 31 Aug 2023 01:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuUkLExYMk2KkNzoqNwZJessDl50UHGa+yP/WwLL1csx93xecY6iXrP63AhVzxZLrSS+Q/XiQDR01A8agdJqg=
X-Received: by 2002:a67:fc0b:0:b0:440:a8c8:f34 with SMTP id
 o11-20020a67fc0b000000b00440a8c80f34mr4587355vsq.3.1693470037516; Thu, 31 Aug
 2023 01:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-3-pbonzini@redhat.com>
 <ZO3JyOmbfrLmD6pd@redhat.com>
In-Reply-To: <ZO3JyOmbfrLmD6pd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 Aug 2023 10:20:26 +0200
Message-ID: <CABgObfbjQjDc1pgPRVLeaVn8MS4_G4Mhve6kyVFqAVaBjTO6gw@mail.gmail.com>
Subject: Re: [PATCH 02/10] meson: update unsupported host/CPU messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Tue, Aug 29, 2023 at 12:34=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> I think I agree wrt to CPUs, but in the case of OS I think
> it is fairly accurate as-is.

Ok, I wanted to leave out the "*intends* to remove support" part,
which is too strong; but I agree that keeping some kind of "support
may go away in future releases unless you act" is a good idea.

Paolo


