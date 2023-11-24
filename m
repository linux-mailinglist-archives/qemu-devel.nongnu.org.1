Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A8C7F7168
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:31:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6TSF-0003HG-Od; Fri, 24 Nov 2023 05:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6TSD-0003H6-US
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:30:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6TSC-0000GI-KP
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700821831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7c/EM57Kt2X9WFX7oRkSH4fU819/B50Aqx8ytOkv/SU=;
 b=NAXfbbXYZMveTehlzKedAWa/YkH+eebIrwRmKSb819JdCCZndatTSOQfMYnDG2Cf7AWzfI
 3g5HRZnTGL1GOyZyef+namdcwKl3Dx8JX0cBFWpQ3KAYyCiuYIbGbMomyXIjVPAtDfqd2p
 kLlslCODWQcTIv2LIf2dQ2ndqbXqrgo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-mFD4hhB6OaiCviuFKPj7WQ-1; Fri, 24 Nov 2023 05:30:30 -0500
X-MC-Unique: mFD4hhB6OaiCviuFKPj7WQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a02ccc2fb53so121193966b.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 02:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700821829; x=1701426629;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7c/EM57Kt2X9WFX7oRkSH4fU819/B50Aqx8ytOkv/SU=;
 b=gBAIfAMaFkFs+iB9C7bMIU69bOEVfrkYDNZW78FumRwYzx8sNIMkAlYlEmlHv9Reyi
 W6EypyJ4uUATWcUpRVAfjgoI+k2NwUU2qxNH/Y+q9qr/Z0G4HcNGVBXfwekTLJX8zTzA
 7tixLbpvn4rGCNzInue1EONM7QlutKDAnD3OflVFz3TMzCc+JXtiDpoW2NYb7MqrJlSn
 P/5WWcScZV3Fkx8qD6LdY/gA775dwLv21suC4Giyrl+mhP8khBuYVNF6mNDrlKIaPF9i
 a/+CCIazE2HtXAUFp7jYE15/lOB85TRQW7FqAyFokxa/q9S//4hIJ0BUlB0ZbEfNuWnh
 XW7Q==
X-Gm-Message-State: AOJu0YzJOlVEtw/NTq1flRgUOkjWINYua4zFM1v/jcnxKKvxv6n665KU
 L3krQkLdm38v0nevyuAoQIt556xpsSQiwkjBeYc8S6unhcoO2mM8xnOmOf2ZUbXsSzAqjNzC1+i
 nwm63UXSg3GytEBg=
X-Received: by 2002:a17:906:fca9:b0:9e2:c6a7:447a with SMTP id
 qw9-20020a170906fca900b009e2c6a7447amr1776965ejb.45.1700821829144; 
 Fri, 24 Nov 2023 02:30:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhtJzdXKWzjT/90RD9sv2RUrLpYCM7kC1r+Ib8vxTbEWYZK3AT0Jc1VTlO0ORmL7gFforhSQ==
X-Received: by 2002:a17:906:fca9:b0:9e2:c6a7:447a with SMTP id
 qw9-20020a170906fca900b009e2c6a7447amr1776937ejb.45.1700821828860; 
 Fri, 24 Nov 2023 02:30:28 -0800 (PST)
Received: from redhat.com ([2.55.10.128]) by smtp.gmail.com with ESMTPSA id
 hg5-20020a170906f34500b00a0a2cb33ee0sm78618ejb.203.2023.11.24.02.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 02:30:28 -0800 (PST)
Date: Fri, 24 Nov 2023 05:30:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231124052806-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <ZV-S1f2cK8MLNizz@redhat.com>
 <20231123172828-mutt-send-email-mst@kernel.org>
 <ZWBngLoa3ERuMxGJ@redhat.com> <87plzzcuzm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87plzzcuzm.fsf@draig.linaro.org>
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

On Fri, Nov 24, 2023 at 10:21:17AM +0000, Alex Bennée wrote:
> LLM's are just a tool like a compiler (albeit with spookier different
> internals).

We already generally don't accept compiler output in patches since
it is not source code by the definition of GPL.

-- 
MST


