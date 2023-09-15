Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E205B7A1D26
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:12:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6jI-0001nk-FN; Fri, 15 Sep 2023 07:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qh6jF-0001nA-0m
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qh6jB-0005lw-TV
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694776272;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jc7fy8fbNH7XT47e4NgDuc0zks3SMia0IFkVwXqiGy0=;
 b=iR95TY3Z0a77a8qeho4CodLd7rjt/ko9HiEbJ71efGnGfQMGDQWWt2pdGFrVY/E10LzM/o
 jDiGl7VI9Io/y5kaF7UkFkp2Q7AH4Rdz7XbKSESeZ5Rtv52wjPVRL2SdRnjyIKsB3wnjrO
 tfsI9dqip9eMcAtdJaHChoU2Ij6Poyk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-uWFcCDKTMBSFqUOJWebg2Q-1; Fri, 15 Sep 2023 07:10:07 -0400
X-MC-Unique: uWFcCDKTMBSFqUOJWebg2Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f3cfe7269so1269145f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 04:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694776204; x=1695381004;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jc7fy8fbNH7XT47e4NgDuc0zks3SMia0IFkVwXqiGy0=;
 b=BbVnq7N0GujldYvJLfeHxjHzx0rkdxPiqV0Oe+B2ZXJ2AfNCXMbLUzoDlOEaN1kJd8
 4dwjuSJqb3H80VWMhBRQM3+IHi/f8AWJUH9n74LT/W5csYqKkTd+itpEWpTcTEg4XyLm
 fRbh99fYYT+r+az7WwsZZghtV8fnmwv2fJL5GLZZJsdtrD/zSD1zIchcbHhX7HE+mtHS
 OlEU+ll93w7PDD2hV6R+QeV4aPENzcYm0lZaNwdGPG25plRD4fZhOuYEixXx7eT3oKIp
 4BzrfeF9aUEW5S1HpkFYAxUJgwpK9zwPr9xL077Wk0pOmOHQvUJx881ZCZ6OeT053osJ
 OtRQ==
X-Gm-Message-State: AOJu0Yw8k1Sin4x/ZpSKtgMW/0tUEBDq30F7dPGssAHRaiqeNzE72dYd
 SR46HFe4nz703/ymQAOYUzt0nmvWJimvFeI/3YAVdJgbkxkeWisnJumRN9UoSDGAQDtSJjbqaMg
 IqIrYyIgiiqwCjAo=
X-Received: by 2002:a5d:6ad2:0:b0:31f:ec06:204 with SMTP id
 u18-20020a5d6ad2000000b0031fec060204mr1113652wrw.52.1694776204752; 
 Fri, 15 Sep 2023 04:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUv3O1aCxJRsu4XkcMgJqUn6mGTghQB5N727wwTUQ3OIcn/jBCHh1YBrAZuN1/VJovbbNnQw==
X-Received: by 2002:a5d:6ad2:0:b0:31f:ec06:204 with SMTP id
 u18-20020a5d6ad2000000b0031fec060204mr1113608wrw.52.1694776204385; 
 Fri, 15 Sep 2023 04:10:04 -0700 (PDT)
Received: from redhat.com ([196.89.220.12]) by smtp.gmail.com with ESMTPSA id
 j4-20020a5d6184000000b003176c6e87b1sm4162665wru.81.2023.09.15.04.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 04:10:03 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: f4bug@amsat.org
Cc: Joao Martins <joao.m.martins@oracle.com>,  mdean@redhat.com,
 felipe@nutanix.com,  afaerber@suse.de,  bazulay@redhat.com,
 bbauman@redhat.com,  cw@f00f.org,  dustin.kirkland@canonical.com,
 eblake@redhat.com,  edgar.iglesias@gmail.com,  eric.auger@redhat.com,
 iggy@theiggy.com,  jan.kiszka@web.de,  jidong.xiao@gmail.com,
 jjherne@linux.vnet.ibm.com,  mimu@linux.vnet.ibm.com,
 peter.maydell@linaro.org,  richard.henderson@linaro.org,
 stefanha@gmail.com,  imp@bsdimp.com,  z.huo@139.com,
 zwu.kernel@gmail.com,  jgg@nvidia.com,  cjia@nvidia.com,
 david.edmondson@oracle.com,  elena.ufimtseva@oracle.com,
 konrad.wilk@oracle.com,  Alessandro Di Federico <ale@rev.ng>,
 anjo@rev.ng,  shameerali.kolothum.thodi@huawei.com,
 wei.w.wang@intel.com,  chao.p.peng@linux.intel.com,
 qemu-devel@nongnu.org,  Mark Burton <mburton@qti.qualcomm.com>
Subject: Re: Call for agenda for 2023-09-19 QEMU developers call
In-Reply-To: <CALUyDQ5Tcby25VQ05REYXsv8v_MO-nVcsHcrQWEAJefPArCoXA@mail.gmail.com>
 (Juan Quintela's message of "Fri, 15 Sep 2023 09:45:46 +0100")
References: <CALUyDQ5Tcby25VQ05REYXsv8v_MO-nVcsHcrQWEAJefPArCoXA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 15 Sep 2023 13:09:59 +0200
Message-ID: <87pm2jvgjc.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Juan Quintela <juan.quintela@gmail.com> wrote:
> Hi
>
> If you have any topics, please add to this email.

You can also update here if you preffer:

https://wiki.qemu.org/QEMUCall#Call_for_agenda_for_2023-09-19

Later, Juan.

> Thanks, Juan.


