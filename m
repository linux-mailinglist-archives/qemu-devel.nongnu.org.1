Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D32F777F7D8
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdB7-0001ZW-I4; Thu, 17 Aug 2023 09:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qWdB5-0001S4-Ke
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:36:43 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qWdB3-0000dK-Co
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:36:43 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4103c24a989so35470551cf.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692279400; x=1692884200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TmgMJj/LUxnCtmlRJIqkaaouvamuZvqnKnWvE7vGBI=;
 b=jOwe6ZBhcPlEXWqmvuoI8Wlf1uDjwkovlZv6G0GI2R8LJXDRVQ4/JiVaYis1Kxw5Ep
 cE7WbjPKZp1ZHEBf4ePD4n8TY13J1pqJpwpYhuTJIWPZ1riPLhOpkRcQsHupf7tk9M0m
 6Uk0wwcRy1DiuhN8klPpGDPsJtLdXXEB5R+C446P6FLuuzhFFdR7OfwlhGoEw7Eug49e
 y2GbYjPGIFH0IsT4jo6+Kncj8O31CQ3flgRH4/gJDDQejH2mWD6vuKpURPOk+00bmwyK
 aGB2aRMBcMVxOCDtGZU6PwMVeSUGLdtlSubliiDw2LZv7PyluM4zOMEg1dw7JI3HiZuE
 7jQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279400; x=1692884200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TmgMJj/LUxnCtmlRJIqkaaouvamuZvqnKnWvE7vGBI=;
 b=BB5p45xapqiqhqrkwlDpGHYXqJmHjdxS0HCI3EYCgl/YcQyOjNuXzifI36x8aFpHul
 Bn+YOPeJ0S3UsxavyliMfIVhx2dsG5t6ekMEaO5+KjkAiQ7N7GowBUJPDSh6kQcLgHqv
 5hkOu95cTuzxX36aD0W87CgA5pdGZh9xx42N7mpuNfQJTToyJqZNs7h11bUQpvtOO1VS
 OLJcDTzMMTV/lTR/5FfNDi5yagFthh7op5SQIhAGmzpF+YwqOsD1idIzF3g5noPzHnU4
 ymoREciZxxiZfcnJ4SI+RNJcYGp22r0sBu5U4mmvzPS26VWSr30DHYE01wU9GfKNAXH+
 K2Fg==
X-Gm-Message-State: AOJu0YyWKi2i3Cq5AxikpHT26L89V7GOkdq02T0+E0erUYTj41HKhZG3
 1PLvDUpbs6Hx+oLXa/wwZIVSMAifrEegbF6mkLQ=
X-Google-Smtp-Source: AGHT+IFT/d67VC4LRJvX/iJgshVDVoRt3YO6rzs7VCbGMgXkDd7vr2xp7lmi5GQWXABPCQ+vPidCfCPPAj8gkly3Uyo=
X-Received: by 2002:a05:622a:453:b0:403:ae1b:c0e8 with SMTP id
 o19-20020a05622a045300b00403ae1bc0e8mr5508176qtx.41.1692279400242; Thu, 17
 Aug 2023 06:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692268800.git.tugy@chinatelecom.cn>
 <d285e8729552a6206ffa1cd4520fc8f9c6be5957.1692268800.git.tugy@chinatelecom.cn>
 <CAJ+F1C+_fGHq3odW6=2krDMhSkOX0krNTUjPnLAuiXHb62naAg@mail.gmail.com>
 <c6b2fb49-d263-4e9c-940d-c97ee9deb62f@chinatelecom.cn>
In-Reply-To: <c6b2fb49-d263-4e9c-940d-c97ee9deb62f@chinatelecom.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Aug 2023 17:36:29 +0400
Message-ID: <CAJ+F1CLLrkm+=cNs8Zdcb9CmQzg=36S2ug=E+jPV9EfjLZ4WxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui/vdagent: call vdagent_disconnect() when agent
 connection is lost
To: Guoyi Tu <tugy@chinatelecom.cn>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, dengpc12@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

Hi

On Thu, Aug 17, 2023 at 5:10=E2=80=AFPM Guoyi Tu <tugy@chinatelecom.cn> wro=
te:
>
>
>
> On 2023/8/17 20:49, =E3=80=90=E5=A4=96=E9=83=A8=E8=B4=A6=E5=8F=B7=E3=80=
=91Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Aug 17, 2023 at 3:32=E2=80=AFPM <tugy@chinatelecom.cn> wrote:
> >>
> >> From: Guoyi Tu <tugy@chinatelecom.cn>
> >>
> >> when the agent connection is lost, the input handler of the mouse
> >> doesn't deactivate, which results in unresponsive mouse events in
> >> VNC windows.
> >>
> >> To fix this issue, call vdagent_disconnect() to reset the state
> >> each time the frontend disconncect
> >>
> >> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> >> Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>
> >> ---
> >>   ui/vdagent.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/ui/vdagent.c b/ui/vdagent.c
> >> index 8a651492f0..386dc5abe0 100644
> >> --- a/ui/vdagent.c
> >> +++ b/ui/vdagent.c
> >> @@ -870,8 +870,11 @@ static void vdagent_disconnect(VDAgentChardev *vd=
)
> >>
> >>   static void vdagent_chr_set_fe_open(struct Chardev *chr, int fe_open=
)
> >>   {
> >> +    VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(chr);
> >> +
> >>       if (!fe_open) {
> >>           trace_vdagent_close();
> >> +        vdagent_disconnect(vd);
> >>           /* To reset_serial, we CLOSED our side. Make sure the other =
end knows we
> >>            * are ready again. */
> >>           qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> >> @@ -922,7 +925,6 @@ static void vdagent_chr_fini(Object *obj)
> >>       VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(obj);
> >>
> >>       migrate_del_blocker(vd->migration_blocker);
> >> -    vdagent_disconnect(vd);
> >
> > why remove this cleanup ? (the function seems safe to call multiple
> > times, if it is the case during finalize)
> >
> Before the instance finalize, the connection will be closed and the
> vdagent_chr_set_fe_open() will be called with be_open set to false,
> which in turn call vdagent_disconnect to clean up resources.

Let's leave it, as it's more straightforward and safe, even if it's
called two times in some code paths.



--=20
Marc-Andr=C3=A9 Lureau

