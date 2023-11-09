Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3757E7046
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:28:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18oX-0004L5-Ed; Thu, 09 Nov 2023 12:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r18oV-0004Kf-H6
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:27:31 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r18oT-00012T-Ry
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:27:31 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5440f25dcc7so1819823a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699550848; x=1700155648; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RuhH/Qhk/2sg+k7lek2T32YisJ5CbwhJVf7ncXAcHy4=;
 b=O7inRCdEuhRQdkEuL37h3VmcOiF/wS1EtOqoms1pJo4aqOoJuRP+jMrA5uu3mVFiC1
 tFGuPWSu1OD4uoigT2baMU4vFdEqA7o7mO5vQCWgCt/Qr4MfluXVyu9ot5OHj+AgbAZi
 MbghsD/Djf/ph+hUbspeFMvLNVclo/4fSr9aSxrO2oEG/XhiYDgYtfHxsahgsH/4rdug
 meTi/wJcUmaDBeS4Pb9cth6CEsjB8+VuzLv8E5XQUrIzDPT2Bk803hmalEDP7qjn0xw6
 mRtVZAG9HgGWnQOmgO5T0Va4kOU2EnodjdnwgDCGPXXNjYQw9jkvhDgxHNNUTBWzMsOs
 Ma7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699550848; x=1700155648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RuhH/Qhk/2sg+k7lek2T32YisJ5CbwhJVf7ncXAcHy4=;
 b=m/2qhgPtAA+ZNaLEQuO/AQDpZt0WBZpg8z+8cT7TMgS9ce+w9y89BcoIf5D5NAWt6L
 +j5lf1wrADYLS1reXrv2fHzJbTdoZ6qeh8GqqUA1OtZmH2RNkfBre3Vfh70WAukk0euS
 Y9oCCWTKRsIcy1QSOL2YXTK4Xyd4R3m975upPF360RLHT7uNBBem0xIHe3CdYYIBsiBl
 iHgItzjbZnSDeVreFOdOtsxStNCt0XHk7ZYbf8UKJ9XpwcmgNVV1DfxIUMlRsyHIufMc
 9gH9oVh79uNHLvsAB5R4OCWKeghm8eJLKJx+MRmZ7Yn64aHPhW1c/NAgxsoOWalFGZj2
 WEzg==
X-Gm-Message-State: AOJu0YyN/fHW7XJUxGylIPY785HfuZVuiwmu/bV+NU/7s6NFlKW8FzAC
 mxnSTXnQT3OvMSzwnfsm/HwLW4yvaJAJoeouWHWQFg==
X-Google-Smtp-Source: AGHT+IGe7kAkuBb1lJJ2dVOCeUISPXOUnNKJDLgGBOi181vfMFGih9qG9q//PzdWEjzYlzrDMwis5LypA8l5yb1TJos=
X-Received: by 2002:a05:6402:1e8e:b0:540:c989:fcdd with SMTP id
 f14-20020a0564021e8e00b00540c989fcddmr5375086edf.11.1699550848137; Thu, 09
 Nov 2023 09:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20231102114054.44360-1-quintela@redhat.com>
 <20231102114054.44360-22-quintela@redhat.com>
 <CAFEAcA_LrLsJ_4PnWLW0cuuTQRP5J7yq48xm8=kLDL39MObn9g@mail.gmail.com>
 <39d99e8d-29ee-431f-82a2-34947f9f4eb5@oracle.com>
In-Reply-To: <39d99e8d-29ee-431f-82a2-34947f9f4eb5@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 17:27:16 +0000
Message-ID: <CAFEAcA8pmJkPe651F9qbFfqiTeeLLxsim-y1yJ2Bc5w6zw6BPw@mail.gmail.com>
Subject: Re: [PULL 21/40] migration: per-mode blockers
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, 
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, John Snow <jsnow@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, 
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 9 Nov 2023 at 17:24, Steven Sistare <steven.sistare@oracle.com> wrote:
>
> On 11/9/2023 12:10 PM, Peter Maydell wrote:
> > On Thu, 2 Nov 2023 at 11:43, Juan Quintela <quintela@redhat.com> wrote:
> >>
> >> From: Steve Sistare <steven.sistare@oracle.com>
> >>
> >> Extend the blocker interface so that a blocker can be registered for
> >> one or more migration modes.  The existing interfaces register a
> >> blocker for all modes, and the new interfaces take a varargs list
> >> of modes.
> >>
> >> Internally, maintain a separate blocker list per mode.  The same Error
> >> object may be added to multiple lists.  When a block is deleted, it is
> >> removed from every list, and the Error is freed.
> >>
> >> No functional change until a new mode is added.
> >
> > Hi; Coverity worries about this code:
> >
> >> -static GSList *migration_blockers;
> >> +static GSList *migration_blockers[MIG_MODE__MAX];
> >>
> >>  static bool migration_object_check(MigrationState *ms, Error **errp);
> >>  static int migration_maybe_pause(MigrationState *s,
> >> @@ -1043,7 +1043,7 @@ static void fill_source_migration_info(MigrationInfo *info)
> >>  {
> >>      MigrationState *s = migrate_get_current();
> >>      int state = qatomic_read(&s->state);
> >> -    GSList *cur_blocker = migration_blockers;
> >> +    GSList *cur_blocker = migration_blockers[migrate_mode()];
> >
> > because it thinks that migrate_mode() might return a value that's
> > too big for the migration_blockers[] array. (CID 1523829, 1523830.)
> >
> > I think Coverity complains mostly because it doesn't understand
> > that the MIG_MODE__MAX in the enum is not a valid enum value
> > that a function returning a MigMode might return. But we can
> > help it out by assert()ing in migrate_mode() that the value
> > we're about to return is definitely a valid mode.
>
> Thanks Peter, I will submit a fix with suggested-by, unless you want to.
> I'll look at all uses of migration_blocker[].
> Would coverity be happier if I also increase the size of the array?

Increasing the array size would also placate Coverity, but I think
in terms of actual bug possibilities the assert() is probably better,
as it would also catch the case of a garbage out-of-range value
getting written into the struct somehow.

thanks
-- PMM

