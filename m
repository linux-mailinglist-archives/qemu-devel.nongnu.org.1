Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6E73F7D9
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:54:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4SM-0001K5-6v; Tue, 27 Jun 2023 04:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qE4SH-0001Jb-58; Tue, 27 Jun 2023 04:53:45 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qE4SD-0007MB-0F; Tue, 27 Jun 2023 04:53:44 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b6985de215so39343381fa.2; 
 Tue, 27 Jun 2023 01:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687856018; x=1690448018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8sxooeCQNyX9OssLkScD8eC7GVeBvHkWyEWq4a1Vsc=;
 b=k4g4J5lMTzA/RVk/4WiTFC6LTh5fSkl4t9qw/p3EWj+gpXUIAI6Y9NU/tknhwFi0vd
 lsshpmeqXUHYBNVttVKBwD+UqinnBLJTeKtH7iWfsK5u1gLm4ZuU9PRQGR2ntF2JyEHr
 UyAineyF++JJOB3leM5prKaA0jBycGCyWs4Wd4Usmrs08QThByAwRx3RBzI5wynMW0UP
 48Vz2IRevjWG0kBAy0GSbMqDyavfGuL5KLNn3mRr4c7OQxXsRcAQULl36t8rwEwDTCTl
 Wnh9gt6pwUVAesNUMHXsJIrUPAe3DdegB0DvY7i9b7zof9k2KygozyT+V3R1MKJtLaAl
 NrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687856018; x=1690448018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8sxooeCQNyX9OssLkScD8eC7GVeBvHkWyEWq4a1Vsc=;
 b=S7wjMCSW/OMIzBDIokzJO5XNIwuPwdXl4+3QNEbaMFDYX3tpLuCrhKn1CjxE+AtE5M
 bb4A6BWpJ5xXpWAVgRAemp4zhPGkDxYaScGFkJ7QEXllanKBuhm9QXiNClNzA/nOpRnr
 PvpB6xFfQuiYvqsxRTsok4Qdbv7JdAr5NY9FvbITu12UzjLa2gd7+VfcylVvOuKhMEgm
 top+zhTxnQkslbNTzQUIW981J4jOunOpks4kRbqa62lMTgSuB+7lG7N5h62aNDtdV4Ur
 q2TA8HiGsAAwf8jeQXc8VomQK7HS3jhjMNzLI2q0w/ryL5/5Iw8lN03+4VrsucXtIFMQ
 nSUA==
X-Gm-Message-State: AC+VfDwZDh4ap9AIA5NljIivTufsJMtSKWHTHW0BmOZLwI3kPDT3+lEl
 JLhij1BTBvQh2aO90V9NFPg04P8xFaxVujPPLfk=
X-Google-Smtp-Source: ACHHUZ4aZnOzYLxRZ2pdX7+0GS4S2c4/qBwwFtd85NlDmyFGpgyV4QTIeMyygRIxzDiiAePqOXdQcNtFm2NoKEG1BfM=
X-Received: by 2002:a2e:7e11:0:b0:2b5:95a8:412b with SMTP id
 z17-20020a2e7e11000000b002b595a8412bmr7413957ljc.52.1687856017238; Tue, 27
 Jun 2023 01:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230622010651.22698-1-yin31149@gmail.com>
 <CAJaqyWfr6XTz7qhMfYR7kJW_A409N7x6hcYQd2ypUD_p6kyc_g@mail.gmail.com>
 <CAKrof1O12p=7zf5jzJca0mtcyoYJHiR-5ubYLD1Q0aszWaKhoQ@mail.gmail.com>
 <CAJaqyWeRy5c6KngJBSXO6cisvQzoqXgTGJ3BDneS2zVT6PpvJg@mail.gmail.com>
In-Reply-To: <CAJaqyWeRy5c6KngJBSXO6cisvQzoqXgTGJ3BDneS2zVT6PpvJg@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Tue, 27 Jun 2023 16:53:25 +0800
Message-ID: <CAKrof1P7MZ_F8m6FbVw20-GAEYQ_pwNE=QFTSbkxNbdUANN3aQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Increase out buffer size for CVQ commands
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22f.google.com
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

On 2023/6/26 17:08, Eugenio Perez Martin wrote:
> On Mon, Jun 26, 2023 at 10:26=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.c=
om> wrote:
>>
>> On 2023/6/25 18:48, Eugenio Perez Martin wrote:
>>> On Thu, Jun 22, 2023 at 3:07=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
>>>>
>>>> According to the VirtIO standard, "Since there are no guarantees,
>>>> it can use a hash filter or silently switch to
>>>> allmulti or promiscuous mode if it is given too many addresses."
>>>> To achive this, QEMU ignores MAC addresses and marks `mac_table.x_over=
flow`
>>>> in the device internal state in virtio_net_handle_mac()
>>>> if the guest sets more than `MAC_TABLE_ENTRIES` MAC addresses
>>>> for the filter table.
>>>>
>>>> However, the problem is that QEMU never marks the `mac_table.x_overflo=
w`
>>>> for the vdpa device internal state when the guest sets more than
>>>> `MAC_TABLE_ENTRIES` MAC addresses.
>>>>
>>>> To be more specific, currently QEMU offers a buffer size of
>>>> vhost_vdpa_net_cvq_cmd_len() for CVQ commands, which represents the si=
ze of
>>>> VIRTIO_NET_CTRL_MAC_TABLE_SET command with a maximum `MAC_TABLE_ENTRIE=
S`
>>>> MAC addresses.
>>>>
>>>> Consequently, if the guest sets more than `MAC_TABLE_ENTRIES` MAC addr=
esses,
>>>> QEMU truncates the CVQ command data and copies this incomplete command
>>>> into the out buffer. In this situation, virtio_net_handle_mac() fails =
the
>>>> integrity check and returns VIRTIO_NET_ERR instead of marking
>>>> `mac_table.x_overflow` and returning VIRTIO_NET_OK, since the copied
>>>> CVQ command in the buffer is incomplete and flawed.
>>>>
>>>> This patch solves this problem by increasing the buffer size to
>>>> vhost_vdpa_net_cvq_cmd_page_len(), which represents the size of the bu=
ffer
>>>> that is allocated and mmaped. Therefore, everything should work correc=
tly
>>>> as long as the guest sets fewer than `(vhost_vdpa_net_cvq_cmd_page_len=
() -
>>>> sizeof(struct virtio_net_ctrl_hdr)
>>>> - 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addresses.
>>>>
>>>> Considering the highly unlikely scenario for the guest setting more th=
an
>>>> that number of MAC addresses for the filter table, this patch should
>>>> work fine for the majority of cases. If there is a need for more than =
thoes
>>>> entries, we can increase the value for vhost_vdpa_net_cvq_cmd_page_len=
()
>>>> in the future, mapping more than one page for command output.
>>>>
>>>> Fixes: 7a7f87e94c ("vdpa: Move command buffers map to start of net dev=
ice")
>>>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>>>> ---
>>>>    net/vhost-vdpa.c | 11 ++++++++++-
>>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>> index 5a72204899..ecfa8852b5 100644
>>>> --- a/net/vhost-vdpa.c
>>>> +++ b/net/vhost-vdpa.c
>>>> @@ -784,9 +784,18 @@ static int vhost_vdpa_net_handle_ctrl_avail(Vhost=
ShadowVirtqueue *svq,
>>>>        };
>>>>        ssize_t dev_written =3D -EINVAL;
>>>>
>>>> +    /*
>>>> +     * This code truncates the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ comm=
and
>>>> +     * and prevents QEMU from marking `mac_table.x_overflow` in the d=
evice
>>>> +     * internal state in virtio_net_handle_mac() if the guest sets mo=
re than
>>>> +     * `(vhost_vdpa_net_cvq_cmd_page_len() - sizeof(struct virtio_net=
_ctrl_hdr)
>>>> +     * - 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addr=
esses for
>>>> +     * filter table.
>>>> +     * However, this situation is considered rare, so it is acceptabl=
e.
>>>
>>> I think we can also fix this situation. If it fits in one page, we can
>>> still send the same page to the device and virtio_net_handle_ctrl_iov.
>>> If it does not fit in one page, we can clear all mac filters with
>>> VIRTIO_NET_CTRL_RX_ALLUNI and / or VIRTIO_NET_CTRL_RX_ALLMULTI.
>>
>> Hi Eugenio,
>>
>> Thank you for your review.
>>
>> However, it appears that the approach may not resolve the situation.
>>
>> When the CVQ command exceeds one page,
>> vhost_vdpa_net_handle_ctrl_avail() truncates the command, resulting in a
>> malformed SVQ command being received by the hardware, which in turn
>> triggers an error acknowledgement to QEMU.
>>
>
> If that happens we can sanitize the copied cmd buffer. Let's start
> with an overflowed unicast table first.
>
> To configure the device we need to transform the command to
> VIRTIO_NET_CTRL_RX_ALLUNI, as we cannot copy all the table to the out
> cmd page. If that succeeds, we can continue to register that in the
> VirtIONet struct.
>
>   We can copy the first MAC_TABLE_ENTRIES + 1 entries and set entries =3D
> (MAC_TABLE_ENTRIES + 1), and then use that buffer to call
> virtio_net_handle_ctrl_iov. That sets VirtIONet.uni_overflow =3D true
> and VirtIONet.all_uni =3D false.
>
> We need to handle the multicast addresses in a similar way, but we can
> find cases where only multicast addresses overflow.
>
> In future series we can improve the situation:
> * Allocating bigger out buffers so more mac addresses fit in it.
> * Mapping also guest pages in CVQ, so the real device is able to read
> the full table but VirtIONet only stores the first MAC_TABLE_ENTRIES
> or .uni_overflow =3D 1.
>
> But I think it should be enough at this point.

Yes, I think this is a good method to update the device internal state
to align with the VirtIO standard when the VIRTIO_NET_CTRL_MAC_TABLE_SET
CVQ command does not fit in one page.

But it seems that we should update the device internal state only when
the hardware successfully receives this CVQ command. Once the hardware
set the VIRTIO_NET_ERR to this CVQ command, we should not change the
device internal state.

To be more specific, there are two scenarios to consider:

- If the CVQ command fits within a single page, the function
vhost_vdpa_net_handle_ctrl_avail() can offer a buffer with the fully
copied CVQ command. In this case, everything should work smoothly.

- If the CVQ command does not fit within a single page, the function
vhost_vdpa_net_handle_ctrl_avail() can only provide a buffer with the
truncated CVQ command. When this buffer is sent to the vpda device, the
device fails to accept this CVQ command and keeps its state unchanged
due to the malformed CVQ. As a result, the device sets the ack
VIRTIO_NET_ERR.

   Consequently, vhost_vdpa_net_handle_ctrl_avail() should immediately
return and keep the device internal state unchanged because the vdpa
device returns VIRTIO_NET_ERR, indicating that the hardware did not
modify the state in this CVQ command.

Therefore, it appears that whenever the VIRTIO_NET_CTRL_MAC_TABLE_SET
CVQ command does not fit in one page, we should not update the device
internal state, because vdpa hardware always fails to accept this CVQ
command due to truncation.

Thanks!



>
> Thanks!
>
>> So if CVQ command exceeds one page, vhost_vdpa_net_handle_ctrl_avail()
>> should not update the device internal state because the SVQ command
>> fails.(Please correct me if I am wrong)
>>
>> It appears that my commit message and comments did not take this into
>> account. I will refactor them in the v2 patch..
>>
>> Thanks!
>>
>>
>>>
>>> Thanks!
>>>
>>>> +     */
>>>>        out.iov_len =3D iov_to_buf(elem->out_sg, elem->out_num, 0,
>>>>                                 s->cvq_cmd_out_buffer,
>>>> -                             vhost_vdpa_net_cvq_cmd_len());
>>>> +                             vhost_vdpa_net_cvq_cmd_page_len());
>>>>        if (*(uint8_t *)s->cvq_cmd_out_buffer =3D=3D VIRTIO_NET_CTRL_AN=
NOUNCE) {
>>>>            /*
>>>>             * Guest announce capability is emulated by qemu, so don't =
forward to
>>>> --
>>>> 2.25.1
>>>>
>>>
>>
>

