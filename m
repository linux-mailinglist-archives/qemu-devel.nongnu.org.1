Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F01A473D99A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhYL-000703-7t; Mon, 26 Jun 2023 04:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qDhYI-0006qI-Rs; Mon, 26 Jun 2023 04:26:26 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qDhYC-0003VD-D0; Mon, 26 Jun 2023 04:26:26 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b6994a8ce3so15629121fa.1; 
 Mon, 26 Jun 2023 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687767977; x=1690359977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SI2ecSVXlY3JkId4IHytM5mIX897kES9PmyCieSRJ+A=;
 b=NORyJ0o/OAQhZzS97/t+1WKR1wvtfpbzGX2dNc2hqtLKJ3T3D/ag7roF5/I61XSKMK
 fSMZWb/LdbkTtBQ/VIwVV9I4oyEOEAh943ehoxS/4JoIA1z7jbnQW+eN76nx6u45gDF8
 NmmxcYbjHutWk5Pnu+J5g6/UnVbJNGyfEOhC3sy0aN6mzeSUDdJavTxpM7z0rgrNNXfq
 qKZNB32edmR7wZ6VWHT2Q9sUDsCtUNok2z1RER0zApwRehGy7NE+2s1HQahwCWF4ysVM
 ANjZeoKCu+dy4pSKlATwKQTD6PG0wa0ifhPNcijBgZLmU5D17TauKdrukBzXTC9foay6
 j16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687767977; x=1690359977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SI2ecSVXlY3JkId4IHytM5mIX897kES9PmyCieSRJ+A=;
 b=BkZDyMgmSfV7UGwyAyh2Fr+QAZ34gTX7a4ktOecZuFCTNC/rof4JniU33FOV1gOnKE
 v/pPHyjSyTOIFuBktC7pjC61QX6Gcht3d5xu1XVDWZ7Nk0IoCOesYr9RD+dUaoXzPPMe
 fzOZWauA2hUSHuXVU3w/rO1IkRk5zHJHPB4Yidq4++tpC2ZUCuFDiJGikJ0/V4FoFkLM
 GacNhYwNwGshlI3yBDRXnktHMeJV6XUG/7Dgqgck6PHKd2pfyruHwnhAAfYfTZ82kkEe
 X2wnxhborhMFB31fsIjxxetURSoXmcFCyw0l1ZivVLs0PacP8g/U8glGiQrg0hc25LxB
 Hppw==
X-Gm-Message-State: AC+VfDyIisrt0bvfrVEQslYnLCuF/pB+/BGW+bk01f+wAmr6KABwlzZC
 qy0mFTrmH1uplEctQO2YOT+mL3d1K6HbTCo0J2U=
X-Google-Smtp-Source: ACHHUZ70Z3YtFyv4KI2LzslDzwLXJ30qAKcLIzxhvOB0aufD7hCMEDsUwoe5eiI1a5iJQqlS1zcncpUKI+ac4pOLHoM=
X-Received: by 2002:a2e:910a:0:b0:2b5:9f54:e28b with SMTP id
 m10-20020a2e910a000000b002b59f54e28bmr3543800ljg.7.1687767977076; Mon, 26 Jun
 2023 01:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230622010651.22698-1-yin31149@gmail.com>
 <CAJaqyWfr6XTz7qhMfYR7kJW_A409N7x6hcYQd2ypUD_p6kyc_g@mail.gmail.com>
In-Reply-To: <CAJaqyWfr6XTz7qhMfYR7kJW_A409N7x6hcYQd2ypUD_p6kyc_g@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Mon, 26 Jun 2023 16:26:04 +0800
Message-ID: <CAKrof1O12p=7zf5jzJca0mtcyoYJHiR-5ubYLD1Q0aszWaKhoQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Increase out buffer size for CVQ commands
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x232.google.com
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

On 2023/6/25 18:48, Eugenio Perez Martin wrote:
> On Thu, Jun 22, 2023 at 3:07=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> According to the VirtIO standard, "Since there are no guarantees,
>> it can use a hash filter or silently switch to
>> allmulti or promiscuous mode if it is given too many addresses."
>> To achive this, QEMU ignores MAC addresses and marks `mac_table.x_overfl=
ow`
>> in the device internal state in virtio_net_handle_mac()
>> if the guest sets more than `MAC_TABLE_ENTRIES` MAC addresses
>> for the filter table.
>>
>> However, the problem is that QEMU never marks the `mac_table.x_overflow`
>> for the vdpa device internal state when the guest sets more than
>> `MAC_TABLE_ENTRIES` MAC addresses.
>>
>> To be more specific, currently QEMU offers a buffer size of
>> vhost_vdpa_net_cvq_cmd_len() for CVQ commands, which represents the size=
 of
>> VIRTIO_NET_CTRL_MAC_TABLE_SET command with a maximum `MAC_TABLE_ENTRIES`
>> MAC addresses.
>>
>> Consequently, if the guest sets more than `MAC_TABLE_ENTRIES` MAC addres=
ses,
>> QEMU truncates the CVQ command data and copies this incomplete command
>> into the out buffer. In this situation, virtio_net_handle_mac() fails th=
e
>> integrity check and returns VIRTIO_NET_ERR instead of marking
>> `mac_table.x_overflow` and returning VIRTIO_NET_OK, since the copied
>> CVQ command in the buffer is incomplete and flawed.
>>
>> This patch solves this problem by increasing the buffer size to
>> vhost_vdpa_net_cvq_cmd_page_len(), which represents the size of the buff=
er
>> that is allocated and mmaped. Therefore, everything should work correctl=
y
>> as long as the guest sets fewer than `(vhost_vdpa_net_cvq_cmd_page_len()=
 -
>> sizeof(struct virtio_net_ctrl_hdr)
>> - 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addresses.
>>
>> Considering the highly unlikely scenario for the guest setting more than
>> that number of MAC addresses for the filter table, this patch should
>> work fine for the majority of cases. If there is a need for more than th=
oes
>> entries, we can increase the value for vhost_vdpa_net_cvq_cmd_page_len()
>> in the future, mapping more than one page for command output.
>>
>> Fixes: 7a7f87e94c ("vdpa: Move command buffers map to start of net devic=
e")
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 5a72204899..ecfa8852b5 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -784,9 +784,18 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
>>       };
>>       ssize_t dev_written =3D -EINVAL;
>>
>> +    /*
>> +     * This code truncates the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ comman=
d
>> +     * and prevents QEMU from marking `mac_table.x_overflow` in the dev=
ice
>> +     * internal state in virtio_net_handle_mac() if the guest sets more=
 than
>> +     * `(vhost_vdpa_net_cvq_cmd_page_len() - sizeof(struct virtio_net_c=
trl_hdr)
>> +     * - 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addres=
ses for
>> +     * filter table.
>> +     * However, this situation is considered rare, so it is acceptable.
>
> I think we can also fix this situation. If it fits in one page, we can
> still send the same page to the device and virtio_net_handle_ctrl_iov.
> If it does not fit in one page, we can clear all mac filters with
> VIRTIO_NET_CTRL_RX_ALLUNI and / or VIRTIO_NET_CTRL_RX_ALLMULTI.

Hi Eugenio,

Thank you for your review.

However, it appears that the approach may not resolve the situation.

When the CVQ command exceeds one page,
vhost_vdpa_net_handle_ctrl_avail() truncates the command, resulting in a
malformed SVQ command being received by the hardware, which in turn
triggers an error acknowledgement to QEMU.

So if CVQ command exceeds one page, vhost_vdpa_net_handle_ctrl_avail()
should not update the device internal state because the SVQ command
fails.(Please correct me if I am wrong)

It appears that my commit message and comments did not take this into
account. I will refactor them in the v2 patch..

Thanks!


>
> Thanks!
>
>> +     */
>>       out.iov_len =3D iov_to_buf(elem->out_sg, elem->out_num, 0,
>>                                s->cvq_cmd_out_buffer,
>> -                             vhost_vdpa_net_cvq_cmd_len());
>> +                             vhost_vdpa_net_cvq_cmd_page_len());
>>       if (*(uint8_t *)s->cvq_cmd_out_buffer =3D=3D VIRTIO_NET_CTRL_ANNOU=
NCE) {
>>           /*
>>            * Guest announce capability is emulated by qemu, so don't for=
ward to
>> --
>> 2.25.1
>>
>

