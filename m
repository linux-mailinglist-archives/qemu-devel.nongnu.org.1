Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6170D9B9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 11:59:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1OmR-0001lN-RI; Tue, 23 May 2023 05:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q1OmP-0001ki-AM
 for qemu-devel@nongnu.org; Tue, 23 May 2023 05:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q1OmN-0004WB-PU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 05:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684835886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meGlVScgp4E/9EyKaknyqI2LILXJtH0E2WucGaDJ54s=;
 b=c1Ohj1fVqYoxyZhj/rMP3oFgxqqIC/ZblemXw0BIZlu5GR6UUYQ0If3bLbh2TYJCaonl0d
 KC68GbeJzjMvSFTSCuKUc9cCNmVn6mJ9EhAR/jfVIosy2GnFtDM2ruoa+K6m2dEqTVPdO+
 JAjDAqvy3IxLEnEY8JXMkymVsx0/IqA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-xn1ZpDCCOsmS_m4z-6bBkw-1; Tue, 23 May 2023 05:58:04 -0400
X-MC-Unique: xn1ZpDCCOsmS_m4z-6bBkw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1ae818c0fdaso43408065ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 02:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684835883; x=1687427883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=meGlVScgp4E/9EyKaknyqI2LILXJtH0E2WucGaDJ54s=;
 b=jhey+eQ3nTSdxx035dbHNBtCLv0AbB4lQc786XqatDesf0byYiR1xJJeuNILui4PDi
 RRBvZwuCWePvz7vX8uwsc67D+RLjGQ9oc9mTGsN/TSCnSZj1MDzVUTPQoXFRVS2F74o5
 NrWRWfiQuzXZOOCNDxLiN15UeMZtYnfIxj3oqfeZ+4b1phlgRuYjLwn0WJLcXWXspHYn
 uHQFIxY1+lTtK8yGKsknHikbZ40Da0IXpR4afZLZhTgNYcG800C1Hzn8FNviIUWxJH2P
 QFYS4CHCe2w0z5B/K4hqrWo896wnKR+xVjeVCMAUPeEQj6v+yYb5G0RpBF4sJ9D9JZ9n
 1keQ==
X-Gm-Message-State: AC+VfDwK0MsdVyQPhmYcKhMFy+5HENCNhIV2fBGgCPBg1L9q+3ixT/La
 Az9vHUZSLTEV4aL/Y1iglgKXSyEO7Eo2P/pKSO0lOAf/VKs9AAZ2MK88CSHa0JRQrn9ksG4Dq0r
 WFsdvos+kStP9PzN5O4fv+n1R0IxkuNA=
X-Received: by 2002:a17:902:db0a:b0:1ac:5c90:23e with SMTP id
 m10-20020a170902db0a00b001ac5c90023emr18904148plx.7.1684835883598; 
 Tue, 23 May 2023 02:58:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5eaaCLR0AdtbwCmNwQRHZdBIQugnxVaNuz8PY0WIXfOKcuW8A8AlV2kVMITyxwADiqfjYI7u+CCxYOkeJARn4=
X-Received: by 2002:a17:902:db0a:b0:1ac:5c90:23e with SMTP id
 m10-20020a170902db0a00b001ac5c90023emr18904119plx.7.1684835883325; Tue, 23
 May 2023 02:58:03 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 May 2023 02:58:02 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20230425102545.162888-1-sunilvl@ventanamicro.com>
 <b520d913-27a9-dea5-53c8-af1cdd967ab2@canonical.com>
 <ZFiRr8d2zyAJlZJv@sunil-laptop>
 <CABJz62OTBEOMzcXLYc=DqRwH8N4DP=o0-kCfALwoREZVyOxLPg@mail.gmail.com>
 <a8dd5f20-30ab-903a-6bd0-15c6a91fdf52@linaro.org>
 <CAKmqyKPHsjtT03MdSoy4i0TgdLBF=88aS6S32hj8hzpz60d6Dg@mail.gmail.com>
 <ZGW/vqOD6E263wDD@sunil-laptop>
 <3168ed46-f6f5-3b4d-8639-05dc499862f8@linaro.org>
 <4e451a41-f60c-456c-2a48-6140a3b4a018@linaro.org>
MIME-Version: 1.0
In-Reply-To: <4e451a41-f60c-456c-2a48-6140a3b4a018@linaro.org>
Date: Tue, 23 May 2023 02:58:02 -0700
Message-ID: <CABJz62O6cd-De0JMS=wyF6DZKmMgHrZULm_j1EFkzfSgj-qxTg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: virt: Assume M-mode FW in pflash0 only when
 "-bios none"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, May 19, 2023 at 06:40:37PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> > On 18/5/23 08:03, Sunil V L wrote:
> > > Agree. While I agree with Philippe, I think we better solve the curre=
nt
> > > problem by going back to v1 of the patch.
>
> BTW clarifying, I'm not rejecting this particular patch; I was just
> trying to correct the idea than "doing what other architectures do"
> is always the right approach ;)

Definitely agree with that :)

But there's a cost associated with going off the beaten path, which
the benefits must then outweight. There seems to be rough consensus
of that not being the case here.

So, can we get v1 merged?

--=20
Andrea Bolognani / Red Hat / Virtualization


