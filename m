Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBA170DA8D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:30:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1PH3-0001j3-PY; Tue, 23 May 2023 06:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1PGz-0001iX-CK
 for qemu-devel@nongnu.org; Tue, 23 May 2023 06:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1PGx-0005xg-Qj
 for qemu-devel@nongnu.org; Tue, 23 May 2023 06:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684837782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6KbEA1ZhSDrkzwgxYmO7ErPoKdaUAEZ6ym87svyHPK8=;
 b=PYo3oibkHDNc1BXvQfYw5SigIIXQu6Vc9zbWbTsSTZvmERDt7bJ50qDDhwhzPNugIHLR+5
 K1HMMH9aLE86rdlfbBCVjSfy/w16REL/k2qY7SH1ou3TLzBGlHWKswM9DT8xi13KqPyHZO
 uI3wbOTqLWUmqcJtGH4TnzsnOmjdsqY=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-oao5qnBYMJm5betNmEVGEQ-1; Tue, 23 May 2023 06:29:41 -0400
X-MC-Unique: oao5qnBYMJm5betNmEVGEQ-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-43537754d86so3844560137.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 03:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684837781; x=1687429781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KbEA1ZhSDrkzwgxYmO7ErPoKdaUAEZ6ym87svyHPK8=;
 b=BuAjOg6bvXhoBJFzUVypcIkduIjV9eYff9wxK6tZi2kFLBcUQ6JiTi6Gs+KeUL34qm
 LgBZJzqHrOcynAonTjVDy2hwPmWgLL+Fxao1KNG4zFATtrhi464+u/ywAKJzasM2eJTj
 UDnZJ2yXo+FT3eKP7og1euQWPfAxEqOeznl3fMYscppiXD7KbP66wu7Txq6raacGndDR
 HyWwnxTu0VJlKfI49iZz4rmO9EMCOo8R3q1jqBlFZvSeX4h9cp/KOXKCtUXmpMY0suYy
 9IYH1BXUhzjCenvaMdpm/1cSZi3F2XTWPtai8G+o5yJGQxoiyuHsJkGNfMAybSwbEd5P
 PHow==
X-Gm-Message-State: AC+VfDwZ+uBTYFsEUqgnn7VrFsFfD9SZo32g3e6y3650U60sPTyN8bqW
 KuxCjV+RmSsYuxnUp0//4zGrjamTnan2E8hkTh9MA+tH3XwGIuFLJ9PnWK6+bbmJ7hH8HlOHTCk
 63Pb9iZTGA4KdICD4X3Q2AJGPG2VVXJE=
X-Received: by 2002:a05:6102:914:b0:439:4882:48b4 with SMTP id
 x20-20020a056102091400b00439488248b4mr2037517vsh.3.1684837780897; 
 Tue, 23 May 2023 03:29:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63CSMrCMDCdWrAGYV27ujyAsEhoEo1e33dubXonRJHT0PrRKmqhOQ/PAkgE43wUvf8IbyGLkCIHsMbvg2wc6E=
X-Received: by 2002:a05:6102:914:b0:439:4882:48b4 with SMTP id
 x20-20020a056102091400b00439488248b4mr2037511vsh.3.1684837780611; Tue, 23 May
 2023 03:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <6467d9133bd9f_57b172b16e2c9d98835043@prd-scan-dashboard-0.mail>
 <4ffdd486-ec7d-49c7-1330-0d0b090735b9@rev.ng>
 <CAFEAcA9ZctmXrCAwsAk6eBeF4ojB4QBwq16TsdcGZPHTin6LEg@mail.gmail.com>
In-Reply-To: <CAFEAcA9ZctmXrCAwsAk6eBeF4ojB4QBwq16TsdcGZPHTin6LEg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 May 2023 12:29:29 +0200
Message-ID: <CABgObfa7N+A=ReW-jme=Nx+wt7rZPcpuy-ANmxepcJMxeXeeWA@mail.gmail.com>
Subject: Re: Help finding Coverity defects for generated Hexagon code
To: Peter Maydell <peter.maydell@linaro.org>
Cc: anjo@rev.ng, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 23, 2023 at 11:18=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> On Mon, 22 May 2023 at 21:24, Anton Johansson <anjo@rev.ng> wrote:
> > Hi,
> >
> > coverity recently reported some defects in code generated by idef-parse=
r
> > (email attached). These defects are expected and we plan to emit a
> > /* coverity[event_tag] */ comment to disable the specific event trigger=
ed.
>
> We don't mark coverity false positives with comments in the
> source. For the free online scanner, we just mark them as
> false positives in the GUI (with an explanation of why they're
> false positives).

They aren't visible in the GUI because the whole "hexagon generated
files" component is marked as not-analyzed; which apparently means it
_is_ analyzed and visible in the emails but not in the GUI.

The event tag for this error should be "dead_error_condition". In
theory, the hexagon generated files could be a good exception to the
rules that we don't mark false positives in the source, but finding
the right line to add the tag can be messy.

Paolo


