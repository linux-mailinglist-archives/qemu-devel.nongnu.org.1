Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 239F9744C4B
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 07:00:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFpBd-0008C8-HI; Sun, 02 Jul 2023 00:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFpBb-0008Bl-Pj
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 00:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFpBa-0006sE-EA
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 00:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688273984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsbBoPs2z6LvynrHmwnweAfd2QOq8Pcy3Dv0f44dPgY=;
 b=D48r8KaUK85Ju8BPDQbNh1F9FFlmBKXfuVBFZd6PYhbnMNc40M7yjTCdMvBggM8B8Jd7FQ
 I7VCcPwDEx6r5lmq1gMMRnu/5JgkoxHl+Jz3LwurgXEjiA9GQmh9++clitwoWYcbKvu3bo
 3XEL+J/dYBKdjuXBDJBVFDLLKaqrM2I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-MX7OD8H-Pheur2yZ0WyZ0g-1; Sun, 02 Jul 2023 00:59:43 -0400
X-MC-Unique: MX7OD8H-Pheur2yZ0WyZ0g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-98e1085308eso349904866b.0
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 21:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688273982; x=1690865982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsbBoPs2z6LvynrHmwnweAfd2QOq8Pcy3Dv0f44dPgY=;
 b=Ya6dO6eJLerg3cZSK9V1hjVdOfp8aTauNPo2tar2JRl9SjVvT13CD6UvheXEMrihzU
 lHAnySIH2ZRC04XSpO57EDaId43pbwI9+tEBrvZAoSk47I9FyedfAqTrE9w5L9qBrm7u
 39Xce9jOwWJQ7L9L/1eMvK5CVUDPKtfOb+lU9Dh+YPKk8qGLcfPeA5aWYmABXCa61sH1
 1gd8bEgj1+Z3cvn7ndFzzk4F4LtuUPie4l5qfYAUOwMz2Aoq/z0U3ruO7jaGE7jM1Ecp
 uwf5fT+Mh82UtnWwA8i+oOVn5UUlu6PC0QfTqXlLqEwytweUtU73g77838bOZ5xTiZrp
 YnCg==
X-Gm-Message-State: ABy/qLZaVHDJEpeyQXexR9UZXwXIkx3u9Is6YS5yFF3YwaDcnnD3vEra
 OLKlhSUAZYtnuHyuPnAH1iYO/yaup8BDsUY7YsFp+i5p1R0HPlHr08Uk8qRpM2Rc6/qy+wYKqgN
 tB6KLxprzRtXsjTk=
X-Received: by 2002:a17:906:a112:b0:988:71c8:9f3a with SMTP id
 t18-20020a170906a11200b0098871c89f3amr6194487ejy.16.1688273982327; 
 Sat, 01 Jul 2023 21:59:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHG1HsyccSbFyyGmmXEaDlLX5Rr0TpnxJw22krVTnMAjdKWnkMgrfCH8DVqswOGKAQchN3F6A==
X-Received: by 2002:a17:906:a112:b0:988:71c8:9f3a with SMTP id
 t18-20020a170906a11200b0098871c89f3amr6194477ejy.16.1688273982012; 
 Sat, 01 Jul 2023 21:59:42 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 r19-20020a1709064d1300b009920c9cb34asm6480578eju.50.2023.07.01.21.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Jul 2023 21:59:41 -0700 (PDT)
Date: Sun, 2 Jul 2023 00:59:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230702005916-mutt-send-email-mst@kernel.org>
References: <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
 <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
 <2ffee496-ec63-ad04-a90b-8c2fadbf3657@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffee496-ec63-ad04-a90b-8c2fadbf3657@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Sat, Jul 01, 2023 at 04:09:31PM +0900, Akihiko Odaki wrote:
> Yes, I want the slot number restriction to be enforced. If it worries you
> too much for regressions, you may implement it as a warning first and then
> turn it a hard error when the next development phase starts.

That's not a bad idea.

-- 
MST


