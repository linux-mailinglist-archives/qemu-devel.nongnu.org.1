Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF7792CB7
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 19:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qda94-0004mb-9p; Tue, 05 Sep 2023 13:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qda8z-0004dZ-VA
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:47:18 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qda8w-0006RI-CW
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:47:17 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-573912a7b14so1678324eaf.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693936032; x=1694540832; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/8s9LxocQf2h46mqO/EkTi2PSDVW2Y9V5kRBMa8tlo=;
 b=KeIdQyJ+ODUNX+Si7QRTpk7+4S8qEwJzKd4P/SfL8LAw3Ux0k2jbE5g/ViEdl99/aC
 CKJ26p0qOEA8WVl2ntnSM2ld8db5XgCVU3IWjwSjL2qVrU56HXq+RBGSvKJLDTSZk11o
 CRQx89ehZ2w40N2zj9sD6848vNmNsVX+7owGzZQ7MibaishDCjF4EVpWnnl0t2kgbqiC
 wqt71O9moF/05tZILz1JcFsL0wPuV3gps9hlE7KkoAJEdK7HQknWWp9cjzi6sIsnjCzH
 D2q2AJWW+7pIvfSVODZX42o+LhKIYkcSl0KuSs9XbIzFfXQMxNvjHEQyOEiLdaMtEe00
 8FlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693936032; x=1694540832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/8s9LxocQf2h46mqO/EkTi2PSDVW2Y9V5kRBMa8tlo=;
 b=YDGt4QvmGX4DicwSUYweuSGnwuFwSbAlqPf206I7SH/EU+n0JMc7P5DI90rjFK9rey
 1uaZGS3cX77KLDtrwhwN0Ttc/HQKjIfCwpJ6DKKF8Lnk/rD8wMy0GkqHCQGj3msgmuOP
 qaQQIwnMiKWeaL7Jeqfa9mFIlk/Dp0APmtVW63K9Jg9GTKuhok1oFMWGg4jjby78jTPJ
 VSzO2pPzhlHs4CM9GXLqbHEDlXIQ8L7RUMfgeuxydbxPS/q26xmKxjwcJCmqY0sKH4cC
 ruBJaUp7Ms2yv22B67lACdX4jRjOHQfle2uYb+WgcmmRsSV/0zMVEgw20tgiM7or76S8
 Lxbg==
X-Gm-Message-State: AOJu0YzK1F2OVlz+cJGnnAJgPCuv/bLhaE7y2ZUZXl8CHDAY24OdK7Wt
 YfUaGAbQOKuDPp8Cgyjo04MnO68vszAVi+elHjg=
X-Google-Smtp-Source: AGHT+IGlBOElIje3A1B/YZqThF9ThoLHvtuPSeA6obMWG/iezPnwwOUUHxR1cFJSHFhMqsFIZaommi4NrnebeaNPokg=
X-Received: by 2002:a4a:3906:0:b0:571:2644:f304 with SMTP id
 m6-20020a4a3906000000b005712644f304mr11269129ooa.8.1693936032495; Tue, 05 Sep
 2023 10:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230904144811.4218-1-farosas@suse.de> <ZPdNCkLk4icmtxf0@x1n>
 <ba47753d-2b9f-4ef9-d715-7624a4be5172@linaro.org>
In-Reply-To: <ba47753d-2b9f-4ef9-d715-7624a4be5172@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 5 Sep 2023 13:46:59 -0400
Message-ID: <CAJSP0QWpggcOwBXLjkvDVVH0L8qNTYnhnjCDJ5GQqG97VNGi5w@mail.gmail.com>
Subject: Re: [PATCH] iothread: Set the GSource "name" field
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 5 Sept 2023 at 12:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 5/9/23 17:45, Peter Xu wrote:
> > On Mon, Sep 04, 2023 at 11:48:11AM -0300, Fabiano Rosas wrote:
> >> @@ -189,11 +193,14 @@ static void iothread_init(EventLoopBase *base, E=
rror **errp)
> >>           return;
> >>       }
> >>
> >> +    thread_name =3D g_strdup_printf("IO %s",
> >> +                        object_get_canonical_path_component(OBJECT(ba=
se)));
> >> +
> >>       /*
> >>        * Init one GMainContext for the iothread unconditionally, even =
if
> >>        * it's not used
> >>        */
> >> -    iothread_init_gcontext(iothread);
> >> +    iothread_init_gcontext(iothread, thread_name);
> >>
> >>       iothread_set_aio_context_params(base, &local_error);
> >>       if (local_error) {
> >
> > I think thread_name might be leaked if error here.  Thanks,
>
> Oops, good catch. Better switch to g_autofree.

Yes, please.

And also make the iothread_init_gcontext(..., char *thread_name)
argument const char * to indicate that the name is owned by the caller
and not modified by iothread_init_gcontext().

Thanks,
Stefan

