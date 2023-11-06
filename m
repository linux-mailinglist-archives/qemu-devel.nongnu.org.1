Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 866557E2BA2
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:07:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03z7-0004Rr-Fj; Mon, 06 Nov 2023 13:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03z3-0004Q9-QT
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03z2-0001m0-9Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699293955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A1qeFn8Cl0TtSZaVtAr464RZcjnpxe3fYiyi24G+fF4=;
 b=bxKt/3xPaWueQaYMPqiO6LK3iXpCAmasG0tmm4NIe7uC3NnO325ucKuW7HxMXulLJEIP3f
 mCnpkyyrptYrgHXDqNIOlQG6irK2dJKiQdKgdSd7jgJGuxBp5wwMjDxjbwgM04B+wsyHxq
 W6GcVqoluntK/OIBYMG+jWQ4tDBoBuE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-RmzDdMMgMWGOSUiRnlIdHQ-1; Mon, 06 Nov 2023 13:05:53 -0500
X-MC-Unique: RmzDdMMgMWGOSUiRnlIdHQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9cf3fad5baeso336190066b.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699293952; x=1699898752;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A1qeFn8Cl0TtSZaVtAr464RZcjnpxe3fYiyi24G+fF4=;
 b=Ba9nU64y6LrS72WV06dOrWMPoqMEGEKd2VHsNptXVQG46ZI24j4Ph26sEMi176GvXR
 GaMMfyX54AFUlTup4RGD2rudH0W+XLkLES7lKFNNgKOdNcKUx/JQ5yMaiTYulCPPTRdv
 Ov/DYYmACp7vWJYskfPZSizjSpRJsfgK+IpiSJvvnHZJj3nKd/L2WL9tkgy0b8VFpHW8
 HIDFxa3FQ5ouwV+iJmuQUeVFSgIQbQhc7DxuSnLbQjfWg2Qb6PvsUUQLtJWZHp4O8QUl
 ctIbRS/tHcH4gJfEcDCrVILxLfsYeyxMMuV28VdrDfV6trpUFgKzdTL3J2UPnOf2WdHa
 GuaA==
X-Gm-Message-State: AOJu0YyRmlPeq12PmfvqfWUmYaHYSjoxf2TxLY1W6N4ek1w/Mjmhj3ti
 2ylQixCik36bXdWyQhQh+yqFhx4NtRdbpz7D9MV9sHrqc6xDV7jD22RctI0Nmk1Z/n4qytY71oU
 GyJR4LMNgthlTWiE=
X-Received: by 2002:a05:600c:4446:b0:406:52f1:7e6f with SMTP id
 v6-20020a05600c444600b0040652f17e6fmr384889wmn.12.1699293128245; 
 Mon, 06 Nov 2023 09:52:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6jEpC4oor/3J0phpEeRldCSPkLULx0LTAOxmzLo2OuPHsgjwG0gmtth40NE9FbTH4x/jCBQ==
X-Received: by 2002:a05:600c:4446:b0:406:52f1:7e6f with SMTP id
 v6-20020a05600c444600b0040652f17e6fmr384863wmn.12.1699293127871; 
 Mon, 06 Nov 2023 09:52:07 -0800 (PST)
Received: from redhat.com ([5.102.242.158]) by smtp.gmail.com with ESMTPSA id
 f8-20020a5d5688000000b0032d9382e6e0sm195319wrv.45.2023.11.06.09.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 09:52:07 -0800 (PST)
Date: Mon, 6 Nov 2023 12:52:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 virtio-fs@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v5 1/6] virtio: split into vhost-user-base and
 vhost-user-device
Message-ID: <20231106125053-mutt-send-email-mst@kernel.org>
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <20231019095610.2818087-2-alex.bennee@linaro.org>
 <20231106121755-mutt-send-email-mst@kernel.org>
 <87o7g6bx1h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7g6bx1h.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 06, 2023 at 05:40:10PM +0000, Alex Bennée wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Oct 19, 2023 at 10:56:05AM +0100, Alex Bennée wrote:
> >> Lets keep a cleaner split between the base class and the derived
> >> vhost-user-device which we can use for generic vhost-user stubs. This
> >> includes an update to introduce the vq_size property so the number of
> >> entries in a virtq can be defined.
> >> 
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> Message-Id: <20231009095937.195728-2-alex.bennee@linaro.org>
> >
> > I applied but I think for this release we are better off just
> > preventing users from instanciating these on command line -
> > developers can always hack code to drop this.
> 
> I guess if a user doesn't read the documentation and makes up some
> random numbers for the properties they deserve what they get?

Problem is users tend to create weird workflows a la https://xkcd.com/1172/

> > Can you post a patch please?
> 
> Is:
> 
>     /* comment out if you want to use backends qemu doesn't know about */
>     .abstract = true,
> 
> really worth it?
> 

For now I'd say so, yes.

> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


