Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E74EC768D6E
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQN3Z-00020q-9O; Mon, 31 Jul 2023 03:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qQN3V-0001zp-3Y
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qQN3S-0003XQ-Sz
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690787457;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=97SZbhHhpKZJwViHq3gl/J7JMzp4oVlAu7PbuWvp4aM=;
 b=gOb6HgzcrPfEh/v/sG923nFkOol+OW7VsYJxOrixlpSC7f8XjHtrSsTlSlbvt2CjQS6PEC
 rvSZOWNXCAeTXyafTwR9czcMzeZJKKqUIzzCJOJ45AaRXcK4tNOp+Y0jOeNbaXKBKArwsS
 OJtMByL2cWq8QLEj1QhzZukQtYKoLTc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-mZNE8F1IOvOMibSKJ2SUPQ-1; Mon, 31 Jul 2023 03:10:55 -0400
X-MC-Unique: mZNE8F1IOvOMibSKJ2SUPQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3176c4de5bbso1880249f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 00:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690787454; x=1691392254;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97SZbhHhpKZJwViHq3gl/J7JMzp4oVlAu7PbuWvp4aM=;
 b=Ql7flCdaUtG8gTE+y1AkaujH0GkdMkVTA5C/e3XDInlio2MeGnf6qiO2ifZ52FL6h3
 BmHKiuG8XjGAczWkYLslmNhSJKbqDxxm3lD0UtRZp1CnB8w+1xrDj2H6LmkWpFDzsR5P
 A8Rb1MYl10hwBN5vzOoK9Ez6hxTAh0SKcTKod01C+lw9M22WLm7mIz37yvk0ZtT79MKS
 phtQro3l+DCD7+jF1WqDT1KLpfTYGM1UadW4MPD8c/a097ctIl4J3zUPA5+HpkQw82Fe
 U0qHyUASbTkm/vkGo/DESpYbzQDVFE3pGMYXgfaTSX2tgfZmaWfnfhbr4xUTmKf/vDFO
 sHYw==
X-Gm-Message-State: ABy/qLZk2hXugnhoEhZZoAMFhJeihAe4CnCqlhUPpbeozG259lEslraH
 22kZL8h48I3sixT6OTu7StBwvmalCt93QqZvDztIEvhLvZr9esBjQEZd7YrmEsx6ZuGJGXotZAy
 PS6/6HFQUqq2gOGY=
X-Received: by 2002:adf:e94f:0:b0:314:3611:3e54 with SMTP id
 m15-20020adfe94f000000b0031436113e54mr5395525wrn.9.1690787454797; 
 Mon, 31 Jul 2023 00:10:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHicGkevujp7NnV8EvEe5NUqHquofAcSgVwIdCw7gykTu0ifO/Q58DqycrcerrIoRkDH7VEXQ==
X-Received: by 2002:adf:e94f:0:b0:314:3611:3e54 with SMTP id
 m15-20020adfe94f000000b0031436113e54mr5395493wrn.9.1690787454457; 
 Mon, 31 Jul 2023 00:10:54 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 u13-20020a5d514d000000b003172510d19dsm12144765wrt.73.2023.07.31.00.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 00:10:54 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,  Thomas Huth
 <thuth@redhat.com>,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Richard
 Henderson <richard.henderson@linaro.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Brian Cain <bcain@quicinc.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,  Xiaojuan Yang
 <yangxiaojuan@loongson.cn>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>,  Chris Wulff <crwulff@gmail.com>,  Marek
 Vasut <marex@denx.de>,  David Hildenbrand <david@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 2/3] tests/migration: Add -fno-stack-protector
In-Reply-To: <20230731065904.5869-3-akihiko.odaki@daynix.com> (Akihiko Odaki's
 message of "Mon, 31 Jul 2023 15:58:55 +0900")
References: <20230731065904.5869-1-akihiko.odaki@daynix.com>
 <20230731065904.5869-3-akihiko.odaki@daynix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 31 Jul 2023 09:10:53 +0200
Message-ID: <875y60d08y.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> A build of GCC 13.2 will have stack protector enabled by default if it
> was configured with --enable-default-ssp option. For such a compiler,
> it is necessary to explicitly disable stack protector when linking
> without standard libraries.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

For whatever is related to migration.
My liker options skills are (very) rusty, so I will let others decided
if this is the correct way to do it O:-)


