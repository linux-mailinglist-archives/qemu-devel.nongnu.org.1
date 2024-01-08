Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47E82748A
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:56:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrz9-0000pM-8c; Mon, 08 Jan 2024 10:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rMrz7-0000p6-9d
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:56:17 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rMrz5-0001bG-Jm
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:56:17 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-59602557ff0so1278619eaf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704729374; x=1705334174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2AqdTUG2m2/afDTqeTldEZ2BjzK2MXyeKiFvnB/M+OE=;
 b=IscwD1pYAnXtxd7jDl7+hNpYkI0jsOBvXfg+2clQiK7tVXlfHzg616BPVubsEGrkPO
 UAO0hT2vcYYdvaCdtVfVb76TwrL44ZXXotKVfwV8TMyKog1gQnL/nPTP/FDhutefqdJl
 4Vcs3QyYsCQGe4JQijKRHERndWW+WzlM5ECyfQAigAf32rrXM8Lfnn4dYZF/x8Qcmtec
 L1iW36MhRb8xQFSvj1DDV6KbBxxXBcKMc5DPMpnUIN6fR/hoP3gu/3fu6PQkY/LdbBhd
 0OSSHLHbnl3O0JIKpFiwZWM/EVkfQXuv4PUnLZJnF9j27ccn8tOFCIVrrT9jEy5jU01M
 Q7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704729374; x=1705334174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2AqdTUG2m2/afDTqeTldEZ2BjzK2MXyeKiFvnB/M+OE=;
 b=LPxUWSPblcGG+DQifKYArjHEOObCWcZRmDhY4DWaaN6VWnm0iObythz9etwKvTr8ha
 SchxGzZgJnofXn6I35b8ULZ6UquLWSkl8Izc9APrI7Yq7e242+U2PyUcfaeU7t+miTa4
 43fmx2q8i8XXfxr6amSAoXYNxBxy4drPIAbe57eIX4JZAWJFX8+vHXHEmw/1LSGYydTJ
 F1LMPiRqq2kCX8OqMPXelV15vhZQBSFsYStKrjsSxWFLqXuxWo+r/4RBsyLO62IwyZ9x
 YbFEmRYj0TJyO+5Ni1zXUYm4GdpHNoC0B5QGBzUZ1ER1QOAHRtOH4vBTVC5Btq3NAWde
 aG2A==
X-Gm-Message-State: AOJu0YwFVpH2FyEZs9ZnoxFBj/HZISBRRo3Jg2eu69THbfmfE1fM4m6S
 wgqg327EsW7KEZLc8SCQTOyHkP3fVdhvImjpm68=
X-Google-Smtp-Source: AGHT+IFXxC0ef+bYo7w/tcI1Xq+CSHNn1w0FjV6LoTaGa29iys4KRvYNTBRjQw+iGP4Ul8GEgx1c9+NnqyJ4LJSoxno=
X-Received: by 2002:a4a:58c3:0:b0:590:95e0:bb6c with SMTP id
 f186-20020a4a58c3000000b0059095e0bb6cmr2385221oob.1.1704729373786; Mon, 08
 Jan 2024 07:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20231207145545.783877-1-aesteve@redhat.com>
 <CAJSP0QVGwTOgtRSaN3JbRKs4h2c_wH1WGTDLaBKme+vhTuDQsQ@mail.gmail.com>
 <CADSE00Ja8fVJUfu5s+mHavoN-BYwSpxB35a44VwU0SWm5bbZzA@mail.gmail.com>
In-Reply-To: <CADSE00Ja8fVJUfu5s+mHavoN-BYwSpxB35a44VwU0SWm5bbZzA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 8 Jan 2024 10:56:01 -0500
Message-ID: <CAJSP0QU9FkyugF8T0654zkJodtf=YF+3iOeLWUW=QqhQP8bYWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Virtio dmabuf improvements
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, kraxel@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2d.google.com
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

On Mon, 8 Jan 2024 at 10:49, Albert Esteve <aesteve@redhat.com> wrote:
> On Mon, Dec 11, 2023 at 10:48=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.=
com> wrote:
>>
>> On Thu, 7 Dec 2023 at 09:55, Albert Esteve <aesteve@redhat.com> wrote:
>> >
>> > v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1005257.html
>> > v1 -> v2:
>> >   - Solved an unitialized uuid value on vhost-user source
>> >   - Changed cleanup strategy, and traverse all objects in the
>> >     table to remove them instead.
>>
>> Please update the vhost-user specification
>> (docs/interop/vhost-user.rst) so people implementing front-ends and
>> back-ends are aware that only the back-end that added a shared
>> resource can remove it.
>>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>
> Will do :)
>
> Should I add the `Acked-by` manually to the commits or does it get automa=
tically picked up later?

Happy New Year! When a patch series is merged then the maintainer
usually (automatically) picks up trailers from the latest revision on
the mailing list. Trailers from earlier revisions may not be present.

When you respin the patch series then you can add trailers manually
with git rebase -i by adding "x git commit --no-edit
--trailer=3D'Acked-by: Stefan Hajnoczi <stefanha@redhat.com>'" lines in
between each commit in the rebase list.

Stefan

