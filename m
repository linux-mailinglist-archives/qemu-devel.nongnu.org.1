Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D3C7F4BE5
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 17:04:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5phE-0005pN-ET; Wed, 22 Nov 2023 11:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5phA-0005p7-DU
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 11:03:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1r5ph8-0000Rh-87
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 11:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700668995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jjaPrmWD640zmcx0WWPrrb9Y/YsmwrfVct0+8k8HHzw=;
 b=FfQt85irJfgVU/q2sbBjVTEDDcMNukzO2gfRbshLlKmq2Gt0pjH/1NaTeYX0cWzSlHU8QK
 mToMFriryCaIPWZHeerra7cM0K1hOt8zo8259xJKFBgtAcqhGu2yMB1RsGkH2NPku7I7/i
 NJ9iP/MVdGjz3mkniZKhVj8G2dUHpg8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-AwaA0pRWPzKzdB1jZnTrtg-1; Wed, 22 Nov 2023 11:02:50 -0500
X-MC-Unique: AwaA0pRWPzKzdB1jZnTrtg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2839a931608so7212290a91.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 08:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700668962; x=1701273762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jjaPrmWD640zmcx0WWPrrb9Y/YsmwrfVct0+8k8HHzw=;
 b=k1BS9I8FC10uS1CK+8p5Tw5Hfe/7MOLos+N0OYm1DBLmbfk80jJLR3OqXxOnZjouIR
 SWI03kB2YHNHY76sRwbBos3MfhTiVRYKM/Va6cP00PpbK1XoeEAxAzJ6+9ANiBu3hGBO
 O8BaBWBcgqsule5gNcfMQD2KyJkhBbKmzGKvH0YTmnkT6lXg18hyR5rUJPy1qnyRyDgX
 5IkhwdmCwsI2tmPGnUa6OlxMlKizMmSnp99pSZagVfNSbaJS3ASvP93DJDxrDgKndZMF
 1S1UWgF5RVPN9oRF82avww5mu6HtDl4cB3dcJCyn9HimmmiIFBOQO39ByMyjM/9J2+XH
 UaXw==
X-Gm-Message-State: AOJu0YzAr3W6wMUSbRxOvbQ+7xsmoJcHdSrVGZM7IXOJt5MAWcYZKKpQ
 bN1DpteHk2fn6MJGxIqDH+n9RVmFkWKJjGuRFAcMs3J6Hlc/rsr5pOG34Z4tfzxUaGW9HDEcs52
 FEf1lGLDqqB37zuT6P2ZSwNRoQzC6M9c=
X-Received: by 2002:a17:90b:4a8b:b0:27d:ba33:6990 with SMTP id
 lp11-20020a17090b4a8b00b0027dba336990mr2648420pjb.10.1700668961855; 
 Wed, 22 Nov 2023 08:02:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuLfQZstki33m3Rj3zRtRsqxmy/oO43Rzki1fB9nsWIg+9puVKVcZuCBu3koikrs90Gq/kR0qyTqymsrLNhBk=
X-Received: by 2002:a17:90b:4a8b:b0:27d:ba33:6990 with SMTP id
 lp11-20020a17090b4a8b00b0027dba336990mr2648398pjb.10.1700668961576; Wed, 22
 Nov 2023 08:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-14-jsnow@redhat.com>
 <87zfz5c28s.fsf@pond.sub.org>
In-Reply-To: <87zfz5c28s.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 22 Nov 2023 11:02:29 -0500
Message-ID: <CAFn=p-bZPJNU9uLBOW1Uqts7kX-+9+dvSNRxwf+VD5hoCHJq9A@mail.gmail.com>
Subject: Re: [PATCH 13/19] qapi/schema: fix typing for
 QAPISchemaVariants.tag_member
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Nov 22, 2023 at 9:05=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > There are two related changes here:
> >
> > (1) We need to perform type narrowing for resolving the type of
> >     tag_member during check(), and
> >
> > (2) tag_member is a delayed initialization field, but we can hide it
> >     behind a property that raises an Exception if it's called too
> >     early. This simplifies the typing in quite a few places and avoids
> >     needing to assert that the "tag_member is not None" at a dozen
> >     callsites, which can be confusing and suggest the wrong thing to a
> >     drive-by contributor.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Without looking closely: review of PATCH 10 applies, doesn't it?
>

Yep!


