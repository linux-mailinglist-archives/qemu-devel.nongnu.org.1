Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FDF7FECD4
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 11:21:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8eA1-0001el-81; Thu, 30 Nov 2023 05:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r8e9v-0001eV-KY; Thu, 30 Nov 2023 05:20:39 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1r8e9t-0002GI-8G; Thu, 30 Nov 2023 05:20:39 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-54bec1d3854so769682a12.2; 
 Thu, 30 Nov 2023 02:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701339635; x=1701944435; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RnYoMQYHgC21W/fkpKiK+YYBKMrcgRtNuxvb9CEadk=;
 b=ftZm3seIoxeBfcaE6oplVNqNPWXqYXQ/LdaL6GgvGCoasSJ3uIzSbvEXDSDkfbCRUB
 CmK1YFo7IVqmuEEO6P3fo+OBrcyGP+ALVBXacYO25My7KcVt+THw10GznYQz0zza/8lF
 VMPcPZiic0wmfHPw6T1t9TQ+eQpowlnRZRjdqS6SVd8eiYuDNH0CMdDveami9s4QivSd
 5Gg50JaVaOBry0MxXfi23wxc1aFeyYd92ovf/HjW3LTV9E1XTQEQnodZLyeFbX43P8wF
 K+TFrH3EXH3Iaan0n9QlAFDd7XbBKF48/wbqtHrjhZ/NtmfZIQK4iPPgzbXm1eSdIPk7
 WpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701339635; x=1701944435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RnYoMQYHgC21W/fkpKiK+YYBKMrcgRtNuxvb9CEadk=;
 b=bWO1N/oAJQ5ZqHOqTCowzVs6AMoQ3y+e7zHjmEMWAk8goItm6GCmOeprp/EsfqUKJ1
 drlZC4PfMeXkeuZxD5n1gVYvNNqyamSzIQ8xNgnXa5JnqOJylQ4sgA/BbEGMkaRNgd53
 7qEbeaPQ9uxcxJe1BNlVC3z+TDWT71l/l+t5QF88Au/PMqev2JV50vVSBJDV4Zhxc0rW
 nfifBjq7Vot9pDYPnKmNjFI2Cu5brCZYGae0D8hc18uAY9u6BnS6JyyWuENZZq+8sZKq
 hG4BEGStKED9p+4x3LZu0iZNI4N2U9pPAiV4ebyvl0A9UfiXmNGvMllXLUWWuBr7eMxD
 oDUg==
X-Gm-Message-State: AOJu0YwwaJ287iU3wew6Fbdj68sgXHHupMW9lEI3dr1vBTnWSTR/zwU5
 c8YOJj5EShk6321DaqNAIKpooWuiPnUYE2+dz3Q=
X-Google-Smtp-Source: AGHT+IFPFpslY0Scsjr474E4sfmsjpkeAafZBqOLrH3W0AOfqdDyrMiQWp9cFb4CqHj4StqiYEsCBCOsBlq8JSC/a+U=
X-Received: by 2002:a17:906:74c6:b0:a16:88e7:daea with SMTP id
 z6-20020a17090674c600b00a1688e7daeamr4900498ejl.54.1701339634603; Thu, 30 Nov
 2023 02:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20231127085641.3729-1-faithilikerun@gmail.com>
 <874jh3czzg.fsf@pond.sub.org>
In-Reply-To: <874jh3czzg.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Thu, 30 Nov 2023 18:20:05 +0800
Message-ID: <CAAAx-8JMuYh8hb=GVQ+cyjU5Topj4OE2bZB2iZxmQEyPFsw27w@mail.gmail.com>
Subject: Re: [RFC v2 0/7] Add persistence to NVMe ZNS emulation
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org, hare@suse.de, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, 
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8830=
=E6=97=A5=E5=91=A8=E5=9B=9B 18:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Sam Li <faithilikerun@gmail.com> writes:
>
> > ZNS emulation follows NVMe ZNS spec but the state of namespace
> > zones does not persist accross restarts of QEMU. This patch makes the
> > metadata of ZNS emulation persistent by using new block layer APIs and
> > the qcow2 img as backing file. It is the second part after the patches
> > - adding full zoned storage emulation to qcow2 driver.
> > https://patchwork.kernel.org/project/qemu-devel/cover/20231127043703.49=
489-1-faithilikerun@gmail.com/
>
> In the future, also add this information the machine-readable way,
> i.e. like
>
>   Based-on: <20231127043703.49489-1-faithilikerun@gmail.com>
>
> However, it doesn't apply on top of that series for me.  Got something I
> could pull?

Weird, I biuld this on top of v6 qcow2 patches. I'll check that after
settling down. I am moving to another city recently.

Thanks,
Sam

