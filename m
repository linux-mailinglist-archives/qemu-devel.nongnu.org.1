Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BEE7562C6
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:31:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNMw-0000Tj-LO; Mon, 17 Jul 2023 08:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1qLNMi-0000Sy-HL
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1qLNMg-0004ju-DJ
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689597009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25ogz6HEvWfURwptrpt4ZlH6bYsWAmOU68ZesyFIy4c=;
 b=QEIW2Ta2JJ5L/CYfoS4rUFKi/a1TaPged81h3oofg8zr/iDGsvR7kD4fUGeTeCPIF8gE4c
 /kmQJSxK8wbRJ6hXQGPQZmemNQqb8i9pWDXlwqfUcbd28z6SWOv0Z8pok3y8uVnrCw2p91
 5GXA3enuHbLE+cBYfrkSR5SHhma5nyY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-0Mtq5wARNTqpVxuy-FCn2Q-1; Mon, 17 Jul 2023 08:30:06 -0400
X-MC-Unique: 0Mtq5wARNTqpVxuy-FCn2Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9932e8e76b9so272376566b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689597005; x=1692189005;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=25ogz6HEvWfURwptrpt4ZlH6bYsWAmOU68ZesyFIy4c=;
 b=VLtvUa9tvaeOKXJk2l3aO9mSFLoNjs6Pm4MVJOhVaGrLvZQPOMOvAkSP2xhVnHW1sT
 X5IwBJirPRsmOLhcUTX1l6KJC87REL/p4QcTCoCDY1x2CmZryXw/Nu9Jf/EYUutFTE9L
 8qnJ+fQ85Vg6kS51dIpEEJcrSqQPUO55LoKLOtlvOa+VCMU0uG6DFvnt0b4J7GOleyPb
 oiBagPyR8gh78usjRa6v0YTmizfi8eyh1X+rcEiD/8BvP5/FQmLkt0wEPH/KBtbjD4gv
 b8OXZEPQ80yDNxsXC98ciBJLt0ozw45oeCBEs/azF9djtuCbwD/OtoKFVXzLgse4LWgv
 V3AQ==
X-Gm-Message-State: ABy/qLYxNWkg2Z9jlewX/ALrZ1zDN9BC5ZLIA/cO3iw/WZsvotQDuwak
 rNx4Hq0V2H7ac/+6nsrrn6h5ta8Foxkq0JjLk2h6Dx6/bCO718Cv7/F6HAcuZShLOPM8Tbs62aC
 Q3T8E9i5SLLWNiuI=
X-Received: by 2002:a17:906:71cf:b0:97e:aace:b6bc with SMTP id
 i15-20020a17090671cf00b0097eaaceb6bcmr9876596ejk.53.1689597005829; 
 Mon, 17 Jul 2023 05:30:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHk4ebZcYJYMlJGB/90/x1JFgavuYpbTQq09jaQHlBa5NrUIxIBlcJZk1MMZSPg84f3HG0dTA==
X-Received: by 2002:a17:906:71cf:b0:97e:aace:b6bc with SMTP id
 i15-20020a17090671cf00b0097eaaceb6bcmr9876577ejk.53.1689597005496; 
 Mon, 17 Jul 2023 05:30:05 -0700 (PDT)
Received: from ridgehead.tt.lan (adsl-dyn166.78-99-34.t-com.sk. [78.99.34.166])
 by smtp.gmail.com with ESMTPSA id
 rk21-20020a170907215500b00993150e5325sm9142137ejb.60.2023.07.17.05.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 05:30:05 -0700 (PDT)
Date: Mon, 17 Jul 2023 14:30:03 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v3 0/4] tests/vm/freebsd: Get up-to-date package list
 from lcitool
Message-ID: <ZLU0Sz8nUUrlZlsY@ridgehead.tt.lan>
References: <20230711144922.67491-1-philmd@linaro.org>
 <96e8c829-74fe-f5ce-0fb0-26de60b9416e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96e8c829-74fe-f5ce-0fb0-26de60b9416e@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eskultet@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 17, 2023 at 02:18:34PM +0200, Thomas Huth wrote:
> On 11/07/2023 16.49, Philippe Mathieu-Daudé wrote:
> > Inspired by this patch from Thomas:
> > https://lore.kernel.org/qemu-devel/20230531090415.40421-1-thuth@redhat.com/
> > 
> > Instead of updating the package list manually, use lcitool vars file.
> > 
> > Since v2:
> > - Commit generated json (Daniel)
> > 
> > Since v1:
> > - Addressed Erik & Daniel comments (generate in JSON)
> > 
> > Philippe Mathieu-Daudé (4):
> >    tests/lcitool: Generate distribution packages list in JSON format
> >    tests/lcitool: Refresh generated files
> >    tests/vm: Introduce get_qemu_packages_from_lcitool_json() helper
> >    tests/vm/freebsd: Get up-to-date package list from lcitool vars file
> > 
> >   tests/docker/dockerfiles/debian-amd64.docker |  2 -
> >   tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
> >   tests/docker/dockerfiles/ubuntu2204.docker   |  2 -
> 
> Thanks, I'm queuing your patches for my next pull request - but I'm dropping
> the hunks that change libpmem-dev and libxen-dev in the docker files -
> otherwise this would just get reverted once somebody using a x86 host runs
> the refresh step again. I hope this issue can be tackled by a future lcitool
> update instead.
> 
>  Thomas
> 

Can you guys please create an issue at
https://gitlab.com/libvirt/libvirt-ci.git to have this officially tracked?

Thanks,
Erik


