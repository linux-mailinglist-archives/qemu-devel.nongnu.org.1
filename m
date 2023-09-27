Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAE97B05E1
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 15:57:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlV26-0003RZ-B1; Wed, 27 Sep 2023 09:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlV24-0003QD-8q
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlV22-0006AX-KB
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695823009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjlsoJ8t5r1fVHwAmiqBwVMtM1ND8XaGcQR3RaezcUE=;
 b=iodcw3jpbVW+6JzWZ2QCqJjflyVUVmu0qZKIZ+GI/2M4M0uJVyt5MeOudEFaYiRiyd6GuX
 wSQHnOpseNO+Ao1zB4bL8A+dqfptyHvjLIoUzkrdD2wmrV3DBqNdFU9ErP0UfopzOKD/fW
 zxBX8zjb/IlvqR6wO91lSVQGr7VHaDA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303--znmMp_6OA6qIkpxjK_C9g-1; Wed, 27 Sep 2023 09:56:48 -0400
X-MC-Unique: -znmMp_6OA6qIkpxjK_C9g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65afce1ff73so27639116d6.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 06:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695823007; x=1696427807;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SjlsoJ8t5r1fVHwAmiqBwVMtM1ND8XaGcQR3RaezcUE=;
 b=k/0TEMFEa+jrAzmheMq9OQnO+pz9f5Knmd9GdrRumKS5CmnL5gqxY2eOaM8osEnL1M
 ifzcOLdoz2K6lJ9+JyOAtE+fHX7Kacx6CP8NeiQhr4Uy5vg9HV9YfGxyE8xLliOUo7kU
 Qhm31z1LuXpFRWAUWJSE+eL3iD1AwhFCYMaEVrPPJaY9E3IAsWcNV4jodSvl6g26tfv9
 /meMmux8UTwB1Nm+HQUbZrtmbCW61ZjuoHXXqv5myTszfh0BTO+C723DFFIJxz9AvoU8
 gDF4BjOQznCVruvnSd2AKljRh5J0U2Q+JwdE0behmkrCR4586RiICr0EE3uttXY/7tUz
 nwLA==
X-Gm-Message-State: AOJu0YwhWXFbU8bR7dJ6LjeDxC2nG4QpUwlRo6CdIt4FicI0VJFWc2F+
 Kz2JJSp71hGK1mjpcKV6MRlkT5DNPhpzp4ZgBQwRPa1X8j2dv6jYM3557oqMXzwD6Pj2enm2NpV
 9FAf7w5/0I5+oxXg=
X-Received: by 2002:a05:6214:3019:b0:64a:8d39:3378 with SMTP id
 ke25-20020a056214301900b0064a8d393378mr2140427qvb.4.1695823007670; 
 Wed, 27 Sep 2023 06:56:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAiDPtHOOi6mo/S28Yi6H1kTvL6JvQC7Og+Lhi0+eaPofMlwTbLGXV4Rjdrw9bz42KYsSZjg==
X-Received: by 2002:a05:6214:3019:b0:64a:8d39:3378 with SMTP id
 ke25-20020a056214301900b0064a8d393378mr2140404qvb.4.1695823007210; 
 Wed, 27 Sep 2023 06:56:47 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 r10-20020a0c9e8a000000b006562b70805bsm3072412qvd.84.2023.09.27.06.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 06:56:46 -0700 (PDT)
Date: Wed, 27 Sep 2023 09:56:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: migration maintenance, governance [Was: Re: [PATCH V4 0/2]
 migration file URI]
Message-ID: <ZRQ0nOssnc0rdw6m@x1n>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
 <dba1e07d-6ebf-9329-7be7-4702ff5dc16d@suse.de>
 <1290963e-9f63-fc70-6729-d355d247c2fd@linaro.org>
 <2f5b9774-e089-3606-905a-8b991dcc5e87@suse.de>
 <a4adf886-7018-4cf5-14d6-cd85172ea501@suse.de>
 <9833202a-8060-1e81-208e-4e240279c298@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9833202a-8060-1e81-208e-4e240279c298@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, Sep 27, 2023 at 03:14:29PM +0200, Claudio Fontana wrote:
> On 9/13/23 15:00, Claudio Fontana wrote:
> > On 8/30/23 15:09, Claudio Fontana wrote:
> >> On 8/22/23 15:25, Philippe Mathieu-Daudé wrote:
> >>> Hi Claudio,
> >>>
> >>> On 22/8/23 14:00, Claudio Fontana wrote:
> >>>> Hello,
> >>>>
> >>>> this series is all reviewed,
> >>>>
> >>>> and is needed as a precondition for further work to improve dramatically the performance of virsh save, virsh restore
> >>>> when migrating to disk, can it be merged?
> >>>
> >>> $ ./scripts/get_maintainer.pl -f migration/meson.build
> >>> Juan Quintela <quintela@redhat.com> (maintainer:Migration)
> >>> Peter Xu <peterx@redhat.com> (reviewer:Migration)
> >>> Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
> >>> qemu-devel@nongnu.org (open list:All patches CC here)
> >>>
> >>> One maintainer, one single point of failure. When the
> >>> maintainer is busy or offline (vacations?) then everybody
> >>> is stuck.
> >>>
> >>> This is usually solved by adding co-maintainers.
> >>>
> >>> Juan, would you accept having co-maintainers helping you
> >>> dealing with the merge process? I'm not volunteering, but
> >>> this can be a good opportunity to make a formal request to
> >>> the community.
> >>>
> >>> Regards,
> >>>
> >>> Phil.
> >>>
> >>
> >> Thanks Philippe,
> >>
> >> I would like to highlight to the QEMU community here how important this is for SUSE,
> >>
> >> to see progress for all the series in the migration area that are currently still waiting and competing for attention.
> >>
> >> The specific features and improvements we are developing or helping to review are a priority for us,
> >> and we are concerned about the rate of progress with the existing governance processes.
> >>
> >> Fabiano is investing a lot of his attention to this area, with features, bugfixes and reviews,
> >> but of course it is up to the community as a whole to address the issue so that reviewed work is merged.
> >>
> >> My attempt here is to make sure that it is recognized as a problem, so it can be hopefully be addressed by the community in a timely fashion,
> >> and we can all benefit from the already developed and reviewed work that is pending.
> >>
> >> Thanks!
> >>
> >> CLaudio
> >>
> >>
> > 
> > Hi Juan, any comments? Would additional help for co-maintenance of live migration help?
> > How can we make things proceed?
> > 
> > From our (SUSE) side we are willing to help as much as we can, and all options are open,
> > whatever it takes to get the multiple series currently waiting to flow again.
> > 
> > Thanks,
> > 
> > Claudio
> 
> Hi any news here?
> 
> We continue to see the migration area of QEMU as basically blocked;
> 
> there are a number of reviewed series out and little progress in merging them,
> as well as a number of improvements not posted to the list at all due to the situation being completely bottlenecked.
> 
> Would a co-maintenance of migration/ from Fabiano be an option?
> 
> Should we organize a call to discuss this if the mailing list does not suffice to discuss this topic?

Yes we can.

Juan will be back next Monday.  Before he left, he told me that he's
preparing the pull.

If next week there's still no pull from migration side then I suppose
someone should start to pick up patches and send PR. I would volunteer
myself already; I should have already perpared a pull a long time ago if I
got ack from Juan.  If Fabiano would like to that'll also be nice.  I don't
know how that works without delegation from the current (solo) maintainer,
though, for either of us to become a maintainer.

Before that, Fabiano can already propose a patch as at least a Reviewer
without the need of any delegation from anyone, as he already did lots of
work in that regard, assume he'll keep doing so to support the migration
subsystem.

I hope Juan will start to figure things out next week.

Thanks,

-- 
Peter Xu


