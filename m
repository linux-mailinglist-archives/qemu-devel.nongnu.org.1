Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 832457D9901
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 14:54:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMLF-0001k2-FA; Fri, 27 Oct 2023 08:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1qwMLB-0001id-Jv
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1qwML7-0001ga-G1
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698411202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3I1XYbq/sNTvfydIMdXOLLOR5nGPnYyhmlipeJMWGPc=;
 b=I1SFi3hdRlkP7jBMSCwEVs0LRYPg/oTRpvTfdnaQ0GPIHjjy+DQ3YjpoAWw9vQnB3RIuRd
 Nywy/RypA3gmwr26B+OMMz1o7+4KKkWRJb0y57TcQ18ApB0/R61VZZ/AR4iMJnBp5P1qj3
 XcghlcF5GrlzkBB4jSmkAp9/v409/OQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-SQ7caK_vOCyTKOxEBaa8Qw-1; Fri, 27 Oct 2023 08:53:21 -0400
X-MC-Unique: SQ7caK_vOCyTKOxEBaa8Qw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41cb4d6744bso26210131cf.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 05:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698411200; x=1699016000;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3I1XYbq/sNTvfydIMdXOLLOR5nGPnYyhmlipeJMWGPc=;
 b=McyZx04jACQTsf8bL56FDWF22tcgv/rHDEVE/5bVB6n2iaUqsqllm0oWFdMjYjysGr
 pFbKzWzYrYrBpJtBgb7jEyBKb3NfObjnNyPlSLDBqcUpMd/taAh0WV/rFsv3F0Y2Xn8q
 TnrQdW3dOU7fsrKVm+MUqpycxS/cf+FNgQeWFTrjzOQJS90D+8B2iAT/WeoG+Mq++9uF
 5iKmzCZtkATDFbTwMJfEv+Q0jS9ZFNogcfn65Xf9H175U6QgGjnwCYiFfOGu9kB/DqDG
 BStkKqxjQaRB+gP2Med4rF7QmORFqvfo1mCNpc6CKCSyXZVA/DFOYqfcKh55tQPvmZN7
 g8Og==
X-Gm-Message-State: AOJu0YwNyGMuSpQFHFKWRHFSqQ5j2dC+bxf+UbLdxsr6MCqBrf+6Ngds
 YdxV/gE4eihmMWloxmH3IG6dM5dlcN8z0E7bmy54j7wZiblMNQPXSNWgSqQUwxiBXYxHdVZjCii
 i9pFC+G8IDVJM3vRnn9A1MDOuVpDc9b0=
X-Received: by 2002:a05:622a:b:b0:412:24e6:a485 with SMTP id
 x11-20020a05622a000b00b0041224e6a485mr2956602qtw.2.1698411200592; 
 Fri, 27 Oct 2023 05:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxH+Z1iO+oX4hJkC3vhSKxdyIf78anNzsL+nD6N+8L/G3WQIdXyveC0ErOjs3MmIhyK+cD8IOUaNu438Gcczk=
X-Received: by 2002:a05:622a:b:b0:412:24e6:a485 with SMTP id
 x11-20020a05622a000b00b0041224e6a485mr2956583qtw.2.1698411200297; Fri, 27 Oct
 2023 05:53:20 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Oct 2023 05:53:19 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
 <20231025190818.3278423-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231025190818.3278423-10-marcandre.lureau@redhat.com>
Date: Fri, 27 Oct 2023 05:53:19 -0700
Message-ID: <CABJz62N7-Bo8j=Dopt960=q8Q+CnDQRDWjMLFLqsLMOq_aZxHg@mail.gmail.com>
Subject: Re: [PATCH v6 09/23] ui/console: allow to override the default VC
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 25, 2023 at 11:08:03PM +0400, marcandre.lureau@redhat.com wrote:
> If a display is backed by a specialized VC, allow to override the
> default "vc:80Cx24C". For that, set the dpy.type just before creating
> the default serial/parallel/monitor.
>
> As suggested by Paolo, if the display doesn't implement a VC (get_vc()
> returns NULL), use a fallback that will use a muxed console on stdio.
>
> This changes the behaviour of "qemu -display none", to create a muxed
> serial/monitor by default.

Have you verified that this doesn't break libvirt? We use '-display
none' for every single VM we run.

-- 
Andrea Bolognani / Red Hat / Virtualization


