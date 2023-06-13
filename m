Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C469B72E894
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 18:35:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q96yp-0006cd-2R; Tue, 13 Jun 2023 12:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96yn-0006cR-Nh
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q96ym-0002bO-DI
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 12:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686674087;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uya0AgCOaGjofrnlerPZBKrRAB4OT2xOS+KYaH1Kx/s=;
 b=JDMk2/jAUTfuVcTQvE4k2wpJlv6OYTYBen5pyCh1GRKcEKyr73LWeWTZ3C4tqyulY0dW7r
 kgh+DhIPNOgBySb9LLzYcE8P2aHfKcyfuXkeUxCzmj0Dwe5/BiusDRSEO8mHs40UxxAUtZ
 Hb/UErdwI/DpwvA57NDvhBp8mmPUoZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-t6cf9i_NN4GCmJiDnvBeCg-1; Tue, 13 Jun 2023 12:34:45 -0400
X-MC-Unique: t6cf9i_NN4GCmJiDnvBeCg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30b218c0bbbso2135244f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 09:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686674084; x=1689266084;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uya0AgCOaGjofrnlerPZBKrRAB4OT2xOS+KYaH1Kx/s=;
 b=UeYxf+cwcp2K7egTcAz+EwwTA12wRNYG3McBo610babuPW5lLODN9tsuTz1Lrhkmo6
 J5dNBRosjuAvFkTYS25KIhfEUjT//Yq4ScVwPrTjo6RZLvhoOGr1YJB4nQLSb2Tmvc03
 QIkM6yD0WjQ4TFAKA/F3qCpTn8qLVFNKveSI5aYNo6KjU/9DVZTV+mM0Kxro3/X35/GY
 3mxWIUxUaMdfIJ/+TXTQOFiy3KFadmKUfS+i1OYT3HreX9yYc//JkyU84CNxKGMU2DWT
 AW3ucAwc1cUHwZAwtB2TZi8jFZcKbd0OZhSHcUixD3FUlOVlp7Kyi081ZpOEtb5SqZEf
 5nng==
X-Gm-Message-State: AC+VfDyc7Sn0cmQjh0+fugn9Giz11GAL0YMUTna/ntNTZFjwPJSneOP8
 4K1I7Dfmu6O1ouWfQQSEI643fKaeS35w2tVfqKjn7El+FoWA2VD/+wZbLhv+W4is+8wFttqXvyz
 V4iPPayXXqjyCcmQ=
X-Received: by 2002:a05:6000:1009:b0:30f:c6c7:47b3 with SMTP id
 a9-20020a056000100900b0030fc6c747b3mr3708460wrx.63.1686674083868; 
 Tue, 13 Jun 2023 09:34:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FA/7jR9NRz1gMTy9R89nZmCkQAMrppyC+aNh6ld5cWB9/xt+qxMkgefXYPGizSGqmpCH4/g==
X-Received: by 2002:a05:6000:1009:b0:30f:c6c7:47b3 with SMTP id
 a9-20020a056000100900b0030fc6c747b3mr3708437wrx.63.1686674083571; 
 Tue, 13 Jun 2023 09:34:43 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 q3-20020adff503000000b002ca864b807csm15883934wro.0.2023.06.13.09.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 09:34:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: ~hyman <hyman@git.sr.ht>
Cc: qemu-devel <qemu-devel@nongnu.org>,  ~hyman <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH QEMU v5 5/8] migration: Refactor auto-converge
 capability logic
In-Reply-To: <168618975839.6361.17407633874747688653-5@git.sr.ht>
 (hyman@git.sr.ht's message of "Wed, 07 Jun 2023 23:32:51 +0800")
References: <168618975839.6361.17407633874747688653-5@git.sr.ht>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 13 Jun 2023 18:34:42 +0200
Message-ID: <87352ve2xp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

~hyman <hyman@git.sr.ht> wrote:
> From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
>
> Check if block migration is running before throttling
> guest down in auto-converge way.
>
> Note that this modification is kind of like code clean,
> because block migration does not depend on auto-converge
> capability, so the order of checks can be adjusted.
>
> Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
> Acked-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


