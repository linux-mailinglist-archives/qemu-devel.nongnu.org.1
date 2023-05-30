Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B1715E53
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3y4d-00054z-Um; Tue, 30 May 2023 08:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3y4Y-00053D-6I
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3y4W-0002zn-Mg
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685448207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YiVo46C0zrSvwBdaTGCJSyEZrxlHNPKMZdREQ+2trjY=;
 b=gWoifJ5cX+PPXE3SIliW6OIhfmWD+V5SfmPqn/k6OWtHfxcccDuye1yUAryKmgl5IBApFE
 CezquXkhODVTrokDv9fbxHoUFo3x5ELyI0qHdN2r3NR6f7dRT/OVolETTlaOpWHwBfqTDv
 VsoDrGGgEEv82eb+Iianfw8b81CZBVc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-asmVeTNtM9emfYgP4cqA8w-1; Tue, 30 May 2023 08:03:23 -0400
X-MC-Unique: asmVeTNtM9emfYgP4cqA8w-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-75b17aa340fso588911685a.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685448203; x=1688040203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YiVo46C0zrSvwBdaTGCJSyEZrxlHNPKMZdREQ+2trjY=;
 b=erChaRRLINKzni8CGXZbpM36n8NROLm2gGb7OpGXcIkCeujFBWHiehYGiziiut4zmS
 3b2GjGcYdaC8ein19777Kq/2TBPb+exLhnT6jmB3FMkam12QuO6nsogEBQCf8Blfg3hN
 ouot3YM0kwtgkVwkWXYmfKxx/+iKKjvCaotCz4fZyoVK/JXno7vPxzu7zb0aP/EQOYPy
 5tnbLwulZIUNCh1GRAN22lV6qB+tANylmTgp+mFOjQ6sh3a/RpDnSxm+iGlDv4Ug4o8e
 3D/fs8w8BvVOiNkZJUFRvV2dO+5/hVxHTi1S/hvspQs+Wp8zKQepKI+GyVmTvYfM3VZF
 r9zQ==
X-Gm-Message-State: AC+VfDzPvRqnH45ZAIi9YCOejcvHzs+QRagA+vxHFD47BkzxUSx6QelE
 xXZwOOdTtBgp4mz9zbej/JTHedGXsXzoyFvVNWfvoa/K3fujyLt6WOuSZMgD9jKlzBiXGCvuld7
 k+FiD7XzAY/Ev9FldT+cSJJgYTz4y2ME=
X-Received: by 2002:a05:620a:2794:b0:75b:23a1:487 with SMTP id
 g20-20020a05620a279400b0075b23a10487mr1540379qkp.77.1685448203215; 
 Tue, 30 May 2023 05:03:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7LXqwLZcyXTQD+dGZIERMJB/hM8vjXVpPnCYRwS8luQdVHZlqjxWFgBjymKorEW+CMi/TvLXnTVjkEaKOTfWw=
X-Received: by 2002:a05:620a:2794:b0:75b:23a1:487 with SMTP id
 g20-20020a05620a279400b0075b23a10487mr1540353qkp.77.1685448202955; Tue, 30
 May 2023 05:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <20230527092851.705884-2-pbonzini@redhat.com>
 <cb9da1f6-183a-151f-49b2-8ec103bba828@redhat.com>
In-Reply-To: <cb9da1f6-183a-151f-49b2-8ec103bba828@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 May 2023 14:03:11 +0200
Message-ID: <CABgObfaT_vOxPaF_GXzGyDD5fNoKZDJU1FEb4_B70C1ddDxPjQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] configure: remove --with-git= option
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, May 30, 2023 at 1:58=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
> The commit cc84d63a42e31c2a that introduce this switch gave a
> rationale:
>
>      Some users can't run a bare 'git' command, due to need for a transpa=
rent
>      proxying solution such as 'tsocks'. This adds an argument to configu=
re to
>      let users specify such a thing:
>
>        ./configure --with-git=3D"tsocks git"

I see, thanks for the additional information--it makes sense to
include it in the commit message.

My impression is that the "smart HTTP" protocol has made this concern
less important. Smart HTTP was introduced in 2009, but back in 2017
the git protocol running on port 9418 was still quite common. QEMU
itself switched from git to https in 2018 with commit a897f22b596b62,
about a year after --with-git was introduced.

Paolo

> But if the plain "git" command is unusable on their system,
> they should likely introduce a proper wrapper on their end
> for this command anyway, so IMHO it's ok if we remove this
> again. Daniel, what do you think?


