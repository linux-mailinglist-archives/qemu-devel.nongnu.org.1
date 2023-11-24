Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F87F7F725E
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:04:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Txg-0002op-8N; Fri, 24 Nov 2023 06:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Txa-0002eU-Cv
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:02:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6TxY-0002Vw-Un
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700823775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6mCIalA3NksRAYvqWh6zRUcsTobfDG5BIcR/w0saNw=;
 b=HdqctmBikWhzIVI03kV0Xy4pvz2UMmG2KH3HXEfHEbxJkOXnnTh0BBzJCDV/Zc9QeD7aAj
 Lah2m+usSVyM9zjHuDUMIYgSb6CQdvXEqFmJ2KA6Sf2cqbShM8nAzedYONSBt6RPiv6eqt
 ngOL6EfK/zS6OvbTf0PotUHwgfRqz84=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-IeS6A4mJMaGpeol5QP9IlA-1; Fri, 24 Nov 2023 06:02:53 -0500
X-MC-Unique: IeS6A4mJMaGpeol5QP9IlA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a02da20c311so123988066b.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700823772; x=1701428572;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6mCIalA3NksRAYvqWh6zRUcsTobfDG5BIcR/w0saNw=;
 b=EkwfsE4eBrlQNHcq/+QSAhvGSswAvZ2ScyPcyVcY6bDQPFS2svJ4tqLydQ6pb6bZhp
 eLNCPR2P0nhbVeFMgWCJHbHkVjP5GkzmSUP5JQ3aU491p4LJNbgQQwtqqCizSMJrZWWG
 SFrcpekPCcvGUg7kQS6tKSO9Ro8sNGOZAm1Q7cpIveXHNlHjZZJPe8XCmJ+1QxIyN8lf
 5d9ttUtfmkCaqBKAdCTFvlccdx92HyGYgxs4288Ml6KAq809n6qDRxt2xAJOwNBIqDOE
 iRrRD/lA+oSSIPBH9bqaPi5HIL71vbK+5iAIguxVJysvDbhCoES9Rnq7gtLUk7MqaBXM
 aHmA==
X-Gm-Message-State: AOJu0Yylz68ktLlzLRLwwYbRXR2e6MbNlvwuOLRo9YogKfRhNPcWuYkU
 EEG/odhiYYQWGS3C5aoFhEJegGebeAwAMDAHeEXUWHZ8TsGeQIKlBtyZRkcmsxPGYloxLe3TTk/
 QScqmBBBc8VAuBeI=
X-Received: by 2002:a17:906:1044:b0:a01:9aa8:9fa8 with SMTP id
 j4-20020a170906104400b00a019aa89fa8mr1945583ejj.0.1700823772099; 
 Fri, 24 Nov 2023 03:02:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg39fxqihm4TCQ6bTkPVuFBm/4PaHBBPDObfaRFcd4J/FCd89NK1AxoQJcn7AgawHozl75qQ==
X-Received: by 2002:a17:906:1044:b0:a01:9aa8:9fa8 with SMTP id
 j4-20020a170906104400b00a019aa89fa8mr1945551ejj.0.1700823771745; 
 Fri, 24 Nov 2023 03:02:51 -0800 (PST)
Received: from redhat.com ([2.55.56.198]) by smtp.gmail.com with ESMTPSA id
 mf12-20020a170906cb8c00b009a13fdc139fsm1925629ejb.183.2023.11.24.03.02.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 03:02:51 -0800 (PST)
Date: Fri, 24 Nov 2023 06:02:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231124055732-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <87r0kgeiex.fsf@draig.linaro.org> <ZV-P6M8seKmMKGCB@redhat.com>
 <20231123183245-mutt-send-email-mst@kernel.org>
 <ZWB4MMrW1JttcxqI@redhat.com> <87edgfcueq.fsf@draig.linaro.org>
 <20231124053749-mutt-send-email-mst@kernel.org>
 <CAFEAcA-0Kusbm_YGo5xu7ztNxdMMe28U5+9Xp=Rp=UG+Ur6EFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-0Kusbm_YGo5xu7ztNxdMMe28U5+9Xp=Rp=UG+Ur6EFg@mail.gmail.com>
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

On Fri, Nov 24, 2023 at 10:43:05AM +0000, Peter Maydell wrote:
> On Fri, 24 Nov 2023 at 10:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Nov 24, 2023 at 10:33:49AM +0000, Alex Bennée wrote:
> > > That probably means we can never use even open source LLMs to generate
> > > code for QEMU because while the source data is all open source it won't
> > > necessarily be GPL compatible.
> >
> > I would probably wait until the dust settles before we start accepting
> > LLM generated code.
> 
> I think that's pretty much my take on what this policy is:
> "say no for now; we can always come back later when the legal
> situation seems clearer".

Absolutely. So I think we should not try and venture into terminology
such as what is ai or try and promote legal copyright theories.
ATM there's no good reason for someone who did not write the code
to put their DCO on the code. If it is not clear who wrote the code
because it was generated and not written then we don't want it.

-- 
MST


