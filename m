Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC447A566E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 02:02:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiOAu-0001Sa-HM; Mon, 18 Sep 2023 20:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qiOAm-0001Ru-W6
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 20:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qiOAY-0006UZ-KA
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 20:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695081643;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGzr111W2DMBO5apKx3TtyuxdBnTgOjIno5U1PJvgFY=;
 b=Zhwm3sKTePhmrd8Y+zSySNFE6fLHduwiwODN+D85WjbPlNTTzGulkT5OTwGEgSx+PJi9xk
 fPnJaBFgcwUhaChBilySYWn1n4Xl1ZKEC6R3t2Krn7M2pIgET2iMlYv2kgoFnhqFHaUTiO
 mj1gzC9b4seDJEuAF+0mTeSXa20+9EU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-Z6r4xpufOuuEgnqnDj99mA-1; Mon, 18 Sep 2023 20:00:42 -0400
X-MC-Unique: Z6r4xpufOuuEgnqnDj99mA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401c19fc097so39256305e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 17:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695081641; x=1695686441;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IGzr111W2DMBO5apKx3TtyuxdBnTgOjIno5U1PJvgFY=;
 b=Zjw4+xf26SxzT7um0UoCfLdfFz29TV3QyZDEcqo+UJ/0FsxN+hptRsUWlHp97KwXKO
 IahFiuZOK7y5pUY/MzWsTsQGIJ4Yub7pjtlLwwxsomUGqMjLF+bt0I5yQMzVSvgx4QVu
 6ackFxdBvYC8a3qned21SrNJ8VBNER7Isb0xgBHa7MYtfZipgsqCh/IqC3waxOHOEG7s
 BtkJ6Rr5TRpho9TyjlqMVZv3EH4kfCOp0spIbi3FcCX5VwW/hQix4mp30ynvoBUV4lpP
 voRtPKqs9FKpMUuSN9Nduyaby8qSeG1LMNOQlCPeY5JEerQXh+2cW/P87KQiiLsHkOMz
 geeg==
X-Gm-Message-State: AOJu0YyB4KeOid2GRXjmvAZ0SS+eeUyizn9bPbekt0Oza3eOlZjAvtJp
 Y2posFlilLJSID+w+iOlYwoS2A/eCG9F1jerGipZBWYR5WbMg79BhoD7Wi1rEa0CgSCThVhlQjb
 e8h5oaBaFh+xMg1E=
X-Received: by 2002:a7b:ce93:0:b0:404:74e3:27ab with SMTP id
 q19-20020a7bce93000000b0040474e327abmr9856695wmj.41.1695081640812; 
 Mon, 18 Sep 2023 17:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwT8C2z0CWBYsjH6B5WdEHxijZ5IUFV3iGprCDorzYxbACgVj+gdXvk3aoLQzHCA2kVq/bgw==
X-Received: by 2002:a7b:ce93:0:b0:404:74e3:27ab with SMTP id
 q19-20020a7bce93000000b0040474e327abmr9856657wmj.41.1695081640083; 
 Mon, 18 Sep 2023 17:00:40 -0700 (PDT)
Received: from redhat.com ([160.177.141.223]) by smtp.gmail.com with ESMTPSA id
 n4-20020a1c7204000000b00402f713c56esm13598389wmc.2.2023.09.18.17.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 17:00:39 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Mark Burton <mburton@qti.qualcomm.com>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>,  Joao Martins
 <joao.m.martins@oracle.com>,  Meirav Dean <mdean@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,  "afaerber@suse.de"
 <afaerber@suse.de>,  "bazulay@redhat.com" <bazulay@redhat.com>,
 "bbauman@redhat.com" <bbauman@redhat.com>,  "cw@f00f.org" <cw@f00f.org>,
 "dustin.kirkland@canonical.com" <dustin.kirkland@canonical.com>,  Eric
 Blake <eblake@redhat.com>,  "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>,  "eric.auger@redhat.com"
 <eric.auger@redhat.com>,  "iggy@theiggy.com" <iggy@theiggy.com>,
 "jan.kiszka@web.de" <jan.kiszka@web.de>,  "jidong.xiao@gmail.com"
 <jidong.xiao@gmail.com>,  "jjherne@linux.vnet.ibm.com"
 <jjherne@linux.vnet.ibm.com>,  "mimu@linux.vnet.ibm.com"
 <mimu@linux.vnet.ibm.com>,  "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>,  "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,  "stefanha@gmail.com"
 <stefanha@gmail.com>,  "imp@bsdimp.com" <imp@bsdimp.com>,  "z.huo@139.com"
 <z.huo@139.com>,  "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,  "cjia@nvidia.com" <cjia@nvidia.com>,
 "david.edmondson@oracle.com" <david.edmondson@oracle.com>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,  Alessandro Di
 Federico <ale@rev.ng>,  "anjo@rev.ng" <anjo@rev.ng>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,  "wei.w.wang@intel.com"
 <wei.w.wang@intel.com>,  "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: Call for agenda for 2023-09-19 QEMU developers call
In-Reply-To: <C9AB9626-9269-4B12-A836-635F911011B3@qti.qualcomm.com> (Mark
 Burton's message of "Mon, 18 Sep 2023 09:10:22 +0000")
References: <CALUyDQ5Tcby25VQ05REYXsv8v_MO-nVcsHcrQWEAJefPArCoXA@mail.gmail.com>
 <87pm2jvgjc.fsf@secure.mitica>
 <C9AB9626-9269-4B12-A836-635F911011B3@qti.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 19 Sep 2023 02:00:37 +0200
Message-ID: <87led3uj4q.fsf@secure.mitica>
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Mark Burton <mburton@qti.qualcomm.com> wrote:
> Seems like we=E2=80=99ve had a bit of a =E2=80=99slower=E2=80=99 time in =
recent weeks -
> presumably =E2=80=9Csummer time=E2=80=9D - If I understand correctly, Lin=
aro are not
> going toe preset this week?
> Maybe we should re-group in the next meeting,=20
>
> So I=E2=80=99m happy to have the meeting tomorrow if Linaro can make it, =
otherwise for 3rd Oct, I have:
> 	I=E2=80=99d like to know where we are with the =E2=80=9CSingle Binary=E2=
=80=9D work.
> 	I think there is still outstanding questions on the whole
> =E2=80=9Cstartup=E2=80=9D subject (related, but not the same)
> 	Alex and I have talked about the plugin-API to cover =E2=80=98icount=E2=
=80=99
> use cases, and that seems to be nudging open a pandora=E2=80=99s box, so I
> think we should discuss that?

As nobody else answered this, I guess we are not having this in the call
for this week.

Move it to next call.

Thanks, Juan.


