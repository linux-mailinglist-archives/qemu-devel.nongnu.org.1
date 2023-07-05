Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A615747B42
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 03:43:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGrXw-0006G7-3V; Tue, 04 Jul 2023 21:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGrXp-0006Fw-Ft
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 21:43:02 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGrXn-0000EZ-Cy
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 21:43:01 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fb5bcb9a28so9558148e87.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 18:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688521376; x=1691113376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2k2KGMWCH1bBjAnV+1l5pry3LrIkchdomIudfQwinE8=;
 b=CK3C7d2KQZNsQHwlTHDir/QhJknYsDCMGeuRG1SKvlNRhGw11OOiiUZjI56twWjSUi
 NHJ/WbUyu68Kz24t/5P4su8dHwz+shmugLt+bKht80wLGzK9ApGgWcYwtp1xgCZdT/Yy
 +Zkef5hMPgikYaTtG7URIPpZw780y+kT1CgN9OiNpMyNrsPxEZArL01dA3VCKEV4NZM/
 T6YJUB3Hd5vL4g1sZIF5BcnAF+3GuG+Tecq31hKR6UZAKpp2sqxC2fP62AQHQxhEZ3rA
 Zmr3ecvWOWxmOFoXsneCXUb8jCmxlFg+TH3iY03RZXC3xJAcpZYKbW78oKjgolocVpCr
 mjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688521376; x=1691113376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2k2KGMWCH1bBjAnV+1l5pry3LrIkchdomIudfQwinE8=;
 b=Mj2HCcJ7zZd5d5PmoVA3f8lh85v+WMSrIxjCsEQ0D3pJpX8Uv2RFGGd8h3wfuRjwHH
 +jJ33OKitmKaxT9LkgJQW0bXY3HZp/eBIPTWPzLFTO/YSE0FoyzPV63uWIqzFZPI5G0c
 ndXQBflRF4iWNGL4Bqt93AeAV5+nHV8X4lc6uLUBHHTKZdzH/WErBPoxmgbcbZ0xNR/H
 O9ekfn+ubUS3/3TROWG6o5E32L0LsV0xKR+lTxhVPax/StuyOCeLKG3qeU7brA9Klj5G
 mZJkuZW2h0Nf5MuEE0HyyzjGczI3mUxnDF2CP9AoPPdOWw2emJZiONGjvV0u5ajasaDQ
 VlbA==
X-Gm-Message-State: ABy/qLYRUmCtzmczQXfd9bof5pswmHzO1f3p8FUUdSy5rZPDlK999303
 A2XQvu68UwzsEIlMC+KDxhqUUke+C0M4UGXGZCE=
X-Google-Smtp-Source: APBJJlGShF0a0orqic+EyEXHQY4lIowWsL+g2S+tG4Bjnyi98R/N2dF7k+aa5oDFgvP1y6v5dVe1RWTazYimNM4kI6g=
X-Received: by 2002:a2e:97d1:0:b0:2b6:e651:8591 with SMTP id
 m17-20020a2e97d1000000b002b6e6518591mr5576553ljj.37.1688521376132; Tue, 04
 Jul 2023 18:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688051252.git.yin31149@gmail.com>
 <2f2560f749186c0eb1055f9926f464587e419eeb.1688051252.git.yin31149@gmail.com>
 <CAJaqyWfq0Sec14Y9UCAtYXRCTyyUwEo0NRBu6uksgESkMVgFUQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfq0Sec14Y9UCAtYXRCTyyUwEo0NRBu6uksgESkMVgFUQ@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 5 Jul 2023 09:42:34 +0800
Message-ID: <CAKrof1PExLDTkfu5B1Kg2s7CQAXbdhGn2s=Pt-g-nfBBRyPTiA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/4] vdpa: Restore MAC address filtering state
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2023/7/4 22:53, Eugenio Perez Martin wrote:
> On Thu, Jun 29, 2023 at 5:26=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch refactors vhost_vdpa_net_load_mac() to
>> restore the MAC address filtering state at device's startup.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>> v2:
>>    - use iovec suggested by Eugenio
>>    - avoid sending CVQ command in default state
>>
>> v1: https://lore.kernel.org/all/00f72fe154a882fd6dc15bc39e3a1ac63f9dadce=
.1687402580.git.yin31149@gmail.com/
>>
>>   net/vhost-vdpa.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 0bd1c7817c..cb45c84c88 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -665,6 +665,57 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *=
s, const VirtIONet *n)
>>           }
>>       }
>>
>> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) =
{
>> +        if (n->mac_table.in_use !=3D 0) {
>
> This may be just style nitpicking, but I find it more clear to return
> early if conditions are not met and then send the CVQ command.

Yes, this makes code more clear to read.

But it appears that we may meet a problem if the function
vhost_vdpa_net_load_x() sends multiple CVQ commands. It is possible that
we might not meet the condition for one of the CVQ commands, but we
could still meet the conditions for other CVQ commands.

Therefore, in the case of vhost_vdpa_net_load_x() sending multiple CVQ
commands, if we still hope to use this style, should we split the
function into multiple functions, with each function responsible for
sending only one CVQ command? Or should we jump to the next CVQ command
instead of returning from the function if the conditions are not met?

Thanks!


> Something like:
> /*
>   * According to ...
>   */
> if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) ||
> (n->mac_table.in_use =3D=3D 0)) {
>    return 0
> }
>
> uni_entries =3D n->mac_table.first_multi,
> ...
> ---
>
> Now I just realized vhost_vdpa_net_load_mac does not follow this for
> checking VIRTIO_NET_F_CTRL_MAC_ADDR.
>
> I'm ok if you leave it this way though.
>
> Thanks!
>
>> +            /*
>> +             * According to virtio_net_reset(), device uses an empty MA=
C filter
>> +             * table as its default state.
>> +             *
>> +             * Therefore, there is no need to send this CVQ command if =
the
>> +             * driver also sets an empty MAC filter table, which aligns=
 with
>> +             * the device's defaults.
>> +             *
>> +             * Note that the device's defaults can mismatch the driver'=
s
>> +             * configuration only at live migration.
>> +             */
>> +            uint32_t uni_entries =3D n->mac_table.first_multi,
>> +                     uni_macs_size =3D uni_entries * ETH_ALEN,
>> +                     mul_entries =3D n->mac_table.in_use - uni_entries,
>> +                     mul_macs_size =3D mul_entries * ETH_ALEN;
>> +            struct virtio_net_ctrl_mac uni =3D {
>> +                .entries =3D cpu_to_le32(uni_entries),
>> +            };
>> +            struct virtio_net_ctrl_mac mul =3D {
>> +                .entries =3D cpu_to_le32(mul_entries),
>> +            };
>> +            const struct iovec data[] =3D {
>> +                {
>> +                    .iov_base =3D &uni,
>> +                    .iov_len =3D sizeof(uni),
>> +                }, {
>> +                    .iov_base =3D n->mac_table.macs,
>> +                    .iov_len =3D uni_macs_size,
>> +                }, {
>> +                    .iov_base =3D &mul,
>> +                    .iov_len =3D sizeof(mul),
>> +                }, {
>> +                    .iov_base =3D &n->mac_table.macs[uni_macs_size],
>> +                    .iov_len =3D mul_macs_size,
>> +                },
>> +            };
>> +            ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s,
>> +                                        VIRTIO_NET_CTRL_MAC,
>> +                                        VIRTIO_NET_CTRL_MAC_TABLE_SET,
>> +                                        data, ARRAY_SIZE(data));
>> +            if (unlikely(dev_written < 0)) {
>> +                return dev_written;
>> +            }
>> +            if (*s->status !=3D VIRTIO_NET_OK) {
>> +                return -EINVAL;
>> +            }
>> +        }
>> +    }
>> +
>>       return 0;
>>   }
>>
>> --
>> 2.25.1
>>
>

