Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C11AE719BBD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hC5-00068c-3u; Thu, 01 Jun 2023 08:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hC3-00068L-Cc
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hC1-0006FE-Hv
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685621652;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMKzxvIrC/cJU2/wSGnSwxFp5K4ZX/+ctfA242HtQcI=;
 b=TI8Tv3LPcvo11KquELIKdXXsD9Xa6VUm0GCrM3HROT/b1+DhYdc1B7marTOwyEB112eBiJ
 z7PNc4mOv69M63mU1JysoVnAbRR1kZl8W0oH6HiZV3WZvF6Du/bAuOi/MZjd58CbiRLbCk
 lry27f5AD9EUVzaKtcPTst/xX82j2J8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-q6scuusaP4eVO_8nAld3Aw-1; Thu, 01 Jun 2023 08:14:11 -0400
X-MC-Unique: q6scuusaP4eVO_8nAld3Aw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30a5d4e5731so404312f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685621650; x=1688213650;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qMKzxvIrC/cJU2/wSGnSwxFp5K4ZX/+ctfA242HtQcI=;
 b=eHeV7dyBwDGlx+DjQ+TBODAMVrN0RRUkdczxrWKM5gFzbHkmnLxF11q1I0Ohr9Ag9E
 zHx6gFUtjntO5M4NswwxOAm6UQUnA9RU/Vl99qeZHRRo6yfQAjvMewG3K72NvsULd+Su
 YDkQ7WVAi4poZ6R3yGgOM0GHDKOdxoAE3qsl/iVHjFtqgQJoaKbERzvkSRnBqCYLyN8j
 Kcixu06Aov3vnrPLHoQgpDGpMPPYaHedcy9a6v8E95iFbWCSht+QnXKBgkDKlZmV7wrG
 4Jbl6Lks3JBrNzH0uFRg8h+2uuhNT6W+TUaYvyWN6whdexf2eme7/DHux2jTTeX36F18
 SvIg==
X-Gm-Message-State: AC+VfDwcL2oam6GQutgYoha9PT6dw9t0jymoJgFxOddE6rmQh9VNQUIa
 TlyiSjsT66IVViHbg0OFlnhRxTwUBp09hYYV0wK5k1XQosHaV7siL+6Vri1xcB3WxBARVvlOVLp
 Unz+zt0PIQE3IDeM=
X-Received: by 2002:adf:e611:0:b0:30a:f033:10d0 with SMTP id
 p17-20020adfe611000000b0030af03310d0mr1672489wrm.6.1685621650027; 
 Thu, 01 Jun 2023 05:14:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zz7/ABkbXbIGnsqksRODvtb8TeXYNdDOC0uxLcdIODI/CkhUnZ5EOlSRfMehwzCgkoIq95A==
X-Received: by 2002:adf:e611:0:b0:30a:f033:10d0 with SMTP id
 p17-20020adfe611000000b0030af03310d0mr1672472wrm.6.1685621649730; 
 Thu, 01 Jun 2023 05:14:09 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 p5-20020a5d4585000000b0030796e103a1sm10267749wrq.5.2023.06.01.05.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:14:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/9] tests/qtest: add support for callback to receive
 QMP events
In-Reply-To: <20230531132400.1129576-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 31 May 2023 14:23:53
 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-3-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 14:14:08 +0200
Message-ID: <87zg5js7lb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> Currently code must call one of the qtest_qmp_event* functions to
> fetch events. These are only usable if the immediate caller knows
> the particular event they want to capture, and are only interested
> in one specific event type. Adding ability to register an event
> callback lets the caller capture a range of events over any period
> of time.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

First of all, I *love* the idea of the patch, but ...

>  static GHookList abrt_hooks;
> @@ -703,8 +705,14 @@ QDict *qtest_qmp_receive(QTestState *s)
>          if (!qdict_get_try_str(response, "event")) {
>              return response;
>          }
> -        /* Stash the event for a later consumption */
> -        s->pending_events =3D g_list_append(s->pending_events, response);
> +
> +        if (s->eventCB) {
> +            s->eventCB(s, qdict_get_str(response, "event"),
> +                       response, s->eventData);
> +        } else {
> +            /* Stash the event for a later consumption */
> +            s->pending_events =3D g_list_append(s->pending_events, respo=
nse);
> +        }
>      }

s->eventCB returns a bool that you are not using.  I think this part of
the code would be more usefule if:

        if (!s->eventCB || !s->eventCB(s, qdict_get_str(response, "event"),
                                       response, s->eventData)) {
            /* Stash the event for a later consumption */
            s->pending_events =3D g_list_append(s->pending_events, response=
);
        }

So if we are not handling the event, we put it on the pending_events
list.

What do you think?

Later, Juan.


