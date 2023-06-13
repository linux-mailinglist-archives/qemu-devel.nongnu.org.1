Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EADFD72E6AB
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:06:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95Yr-000485-1m; Tue, 13 Jun 2023 11:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q95Ww-0003lT-5A
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 11:02:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q95Wt-0008J1-KV
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 11:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XXcqIalD4ikHFw7gVxTuUkObp4YVHW/HmetFjcYKlh4=;
 b=ev4b8bTaxBEuh1vb5SjkJhdTCfDsI+TCvSoEPdPF8iCtFhusOlHIvbB7Oc8+AkUzmTpuuy
 fyxu8aOa9vnOQL1OlcWu6o/if8X7QQ+91aQ6L0r7MxQ8qrygz/zZ6VBVxm/1qbF5zlFFqc
 f61nJYotZgVjOg7obyYa3sq/c+2skw8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-JfHdiAsmP16O9sAYoJBKBA-1; Tue, 13 Jun 2023 11:01:46 -0400
X-MC-Unique: JfHdiAsmP16O9sAYoJBKBA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30fc5d6e697so825234f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 08:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686668504; x=1689260504;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XXcqIalD4ikHFw7gVxTuUkObp4YVHW/HmetFjcYKlh4=;
 b=NgkEJnk2FfunAMLt69/jUs7/rdFakSQZVqXr+xuhAQRucoLEPJ5Ko+MExCxybJ/Aog
 tn0meTjfxM36XEZ4JxKykNd++oQEbl/qx5qkSIRMqfwX1Zw8vjlwxiywLRm6SRn426vw
 rGW9WalasB7aKWby6aXI7jI+X+NE3zmJeCNATXBKRf8+w/Fv27KoR/l4NvaxqEKtm9i8
 sV5svBTwd8TiFWOJa3FSak4inEM3pHcHRwRWbHo4UhFNivEWpuUHae0qjci+HKIuixV4
 0QCX9/qwgErVbO0qOSpZ52wmIGoXCoQQDAQpegeiejsI2AxGx2IZaqibfJKC+bzqJAVy
 eDcw==
X-Gm-Message-State: AC+VfDztlUkVN60I9ngmEzopzR66a0mJIlx7eabccQMqET69HFlbNew1
 jGsYKZ4dE5hoRDq6WMF80LPb4P4AUo2hF8NBHua3RSOOflhrka9dHrrHLFQS1gYyMUsK8XeLgNA
 ZiZwri1Iouy11P3HRxrK3kTE9nwAG
X-Received: by 2002:adf:ed89:0:b0:2ce:d84d:388f with SMTP id
 c9-20020adfed89000000b002ced84d388fmr7287041wro.40.1686668503745; 
 Tue, 13 Jun 2023 08:01:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ayPG6cyGo5T5HF4/Lri0v0kOKyl5nWCg8u2XyQmrysUB/OFh7CoM2DA4AG5Xv6ShxdXJsjQ==
X-Received: by 2002:adf:ed89:0:b0:2ce:d84d:388f with SMTP id
 c9-20020adfed89000000b002ced84d388fmr7287023wro.40.1686668503336; 
 Tue, 13 Jun 2023 08:01:43 -0700 (PDT)
Received: from redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
 by smtp.gmail.com with ESMTPSA id
 d6-20020adffd86000000b0030ae87bd3e3sm15562033wrr.18.2023.06.13.08.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 08:01:42 -0700 (PDT)
Date: Tue, 13 Jun 2023 11:01:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 02/15] hw/pci-host/q35: Fix double, contradicting
 .endianness assignment
Message-ID: <20230613110114-mutt-send-email-mst@kernel.org>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-3-shentey@gmail.com>
 <20230612150154.438d842f@imammedo.users.ipa.redhat.com>
 <CAG4p6K6yR+iJmjnYOkJFd=GbxPU+QpkzTSEfW1VuUwM95o5_iQ@mail.gmail.com>
 <20230613044810-mutt-send-email-mst@kernel.org>
 <0ff30d22-25f9-750e-3ec1-f0988eee5668@eik.bme.hu>
 <20230613150502.74e46018@imammedo.users.ipa.redhat.com>
 <3b1710cc-b905-e005-a8ab-97513d3c6702@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b1710cc-b905-e005-a8ab-97513d3c6702@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Jun 13, 2023 at 03:40:28PM +0200, Philippe Mathieu-Daudé wrote:
> On 13/6/23 15:05, Igor Mammedov wrote:
> > On Tue, 13 Jun 2023 13:07:17 +0200 (CEST)
> > BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > 
> > > On Tue, 13 Jun 2023, Michael S. Tsirkin wrote:
> > > > On Tue, Jun 13, 2023 at 09:46:53AM +0200, Bernhard Beschow wrote:
> > > > > On Mon, Jun 12, 2023 at 3:01 PM Igor Mammedov <imammedo@redhat.com> wrote:
> > > > > 
> > > > >      On Sun, 11 Jun 2023 12:33:59 +0200
> > > > >      Bernhard Beschow <shentey@gmail.com> wrote:
> > > > >     > Fixes the following clangd warning (-Winitializer-overrides):
> > > > >     >
> > > > >     >   q35.c:297:19: Initializer overrides prior initialization of this
> > > > >      subobject
> > > > >     >   q35.c:292:19: previous initialization is here
> > > > >     >
> > > > >     > Settle on native endian which causes the least overhead.
> > > > >      indeed it doesn't matter which way we read all ones, so that should work.
> > > > >      but does it really matter (I mean the overhead/what workload)?
> > > > >      If not, I'd prefer explicit LE as it's now to be consistent
> > > > >      the the rest of memops on Q35.
> 
> Meaning trying to optimize this single MR on big-endian is irrelevant :)
> 
> > > > > 
> > > > > I got a comment from Michael about this in [1], so I've changed it. I don't
> > > > > mind changing it either way.
> > > > > 
> > > > > Best regards,
> > > > > Bernhard
> > > > > 
> > > > > [1] https://patchew.org/QEMU/20230214131441.101760-1-shentey@gmail.com/
> > > > > 20230214131441.101760-3-shentey@gmail.com/#
> > > > > 20230301164339-mutt-send-email-mst@kernel.org
> > > > 
> > > > Hmm it's not terribly important, and the optimization is trivial,
> > > > but yes people tend to copy code, good point. Maybe add a comment?
> > > > /*
> > > > * Note: don't copy this!  normally use DEVICE_LITTLE_ENDIAN. This only
> > > > * works because we don't allow writes and always read all-ones.
> > > > */
> > > 
> > > Why don't you leave DEVICE_LITTLE_ENDIAN and remove DEVICE_NATIVE_ENDIAN
> > > instead? If this only returns all 1s then it does not matter and also
> > > DEVICE_LITTLE_ENDIAN was the last assignment so likely that was effective
> > > so far anyway.
> > 
> > I'm in favor of this as well,
> > the 'optimization' and then piling comments on top to clarify confusion
> > should be justified by usefulness of it (no perf numbers/usecase were present so far).
> > In absence of above, I'd prefer real hw behavior (LE in this case).


OK I'm fine with this too. Sorry about leading you astray.

-- 
MST


