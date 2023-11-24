Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1EA7F72ED
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:40:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UY0-0004CF-3f; Fri, 24 Nov 2023 06:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6UXy-0004Bk-9D
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:40:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6UXw-0000lg-AO
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700826031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKu7Cad2+Z3vWB9K04YILgrjwONqQ4owO/98bpvrKC0=;
 b=MJ4vZTCGo/LZWuT8W85rgXymQc04m6ZvlDyOJa/dp/UDZYeXgA9V8gPQjLAeakYqX14aVE
 mUeF7r9u1TswhFCSbkFbH+Dva9n+x7pJthbH94ydrADMWP94CN6BPYx4hMkWLHE73WhJL7
 RppgSMxjCGGhL+vNGhbxQXbnWbZ69Lg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-EGWLM05xPGqbsaZDNf_FkQ-1; Fri, 24 Nov 2023 06:40:30 -0500
X-MC-Unique: EGWLM05xPGqbsaZDNf_FkQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a00dd93a5f1so131940466b.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700826029; x=1701430829;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sKu7Cad2+Z3vWB9K04YILgrjwONqQ4owO/98bpvrKC0=;
 b=vti3d4J+eSwF74vSfJeFUE8tDF1UcGLXGfjM5fCO/nrU7T/Zwusn1ht3dKonXn8ruE
 hYhCxCLdEGgEYvsoPXLJt+214qogxCH6PLYTPlYCpZmM1KHJWIV6Dc7gAgt7Zw87i8l2
 pHdEX2uUnoMgYbH8XFYGGvD5RU+XnqppuLrrLbknGQNx5DVRss4JyIB8cLeu0HzR9XFB
 RwIEv79nbeYTQd89/DR+3O6JwDr6jX8/k2V2S0n5VhEkTqsYS9T2lCbwCh1OQXTaDq6+
 VUJuGFh3ZqgmQWUvZXJc5dYcZGhkfBnK3uMIyuJHeVSlRIJIDcvDhw1vLeFbc3gS8kQ/
 rUOQ==
X-Gm-Message-State: AOJu0YxS77lJuxhzeXsFxgJbOxrOU6yKIX61gQiHTpwSxyFHpY5Mt5hC
 yFPEP+Ih12cy/wkuVoWkiyHa5hF4cW4H5eLhs5ieYc6NhcLcaFqb1LId5ZkVEF5za06Ps0x/LtE
 vjMsRqyM7fBMNW8o=
X-Received: by 2002:a17:907:c287:b0:9fc:1eaa:6d5f with SMTP id
 tk7-20020a170907c28700b009fc1eaa6d5fmr1751998ejc.73.1700826029369; 
 Fri, 24 Nov 2023 03:40:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHom4N2K0v1R/nkuaJDFeUDzamSpIIrY3pHREIyTZpPr5ifEb+8snrq35eNaTWP5k2c+nTcmg==
X-Received: by 2002:a17:907:c287:b0:9fc:1eaa:6d5f with SMTP id
 tk7-20020a170907c28700b009fc1eaa6d5fmr1751973ejc.73.1700826028979; 
 Fri, 24 Nov 2023 03:40:28 -0800 (PST)
Received: from redhat.com ([2.55.10.128]) by smtp.gmail.com with ESMTPSA id
 c12-20020a170906170c00b0099ddc81903asm1962607eje.221.2023.11.24.03.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 03:40:27 -0800 (PST)
Date: Fri, 24 Nov 2023 06:40:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231124063951-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-3-berrange@redhat.com>
 <87r0kgeiex.fsf@draig.linaro.org> <ZV-P6M8seKmMKGCB@redhat.com>
 <20231123183245-mutt-send-email-mst@kernel.org>
 <ZWB4MMrW1JttcxqI@redhat.com> <87edgfcueq.fsf@draig.linaro.org>
 <20231124053749-mutt-send-email-mst@kernel.org>
 <CAFEAcA-0Kusbm_YGo5xu7ztNxdMMe28U5+9Xp=Rp=UG+Ur6EFg@mail.gmail.com>
 <ZWCK67xSasXOhU0m@redhat.com>
 <20231124063831-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124063831-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

On Fri, Nov 24, 2023 at 06:39:21AM -0500, Michael S. Tsirkin wrote:
> On Fri, Nov 24, 2023 at 11:37:15AM +0000, Daniel P. Berrangé wrote:
> > On Fri, Nov 24, 2023 at 10:43:05AM +0000, Peter Maydell wrote:
> > > On Fri, 24 Nov 2023 at 10:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Nov 24, 2023 at 10:33:49AM +0000, Alex Bennée wrote:
> > > > > That probably means we can never use even open source LLMs to generate
> > > > > code for QEMU because while the source data is all open source it won't
> > > > > necessarily be GPL compatible.
> > > >
> > > > I would probably wait until the dust settles before we start accepting
> > > > LLM generated code.
> > > 
> > > I think that's pretty much my take on what this policy is:
> > > "say no for now; we can always come back later when the legal
> > > situation seems clearer".
> > 
> > Yes, that was my thoughts exactly.
> > 
> > And if anyone comes along with a specific LLM/AI code generator that
> > they believe can be used in a way compatible with the DCO, they can
> > ask for an exception to the general policy which we can discuss then.
> 
> Yea. But why do you keep worrying about LLM/AI mess?  Are there code
> generators whose output do allow? What are these?

And to clarify I mean source code in the GPL sense so please do not
say "compiler".

-- 
MST


