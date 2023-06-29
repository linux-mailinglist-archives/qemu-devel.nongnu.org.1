Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC05A74249F
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpPe-0005Iu-D6; Thu, 29 Jun 2023 07:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qEpPO-0005E1-Nh; Thu, 29 Jun 2023 07:02:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qEpPM-00018D-Eo; Thu, 29 Jun 2023 07:01:54 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TAlDaO014428; Thu, 29 Jun 2023 11:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=q+jVcJk1cuCUFWD7dWQ3cm4kL97ZXQQQjHI1+WTnJF8=;
 b=WRBqWD6tKEuVxxGErJTIuPfU09o4mwYvL8PtJAS5tlQRwAFgsbep0WSsGDW8ybiYFO14
 oIGlJ489lPBu80iCpnK/sYCHhdovcUGN8PExjyUDGA5ZB5w3f1nkVB9fOVdEjOCrRSEO
 Z88u9fOVwUFXHH1sD1Mc/7SlxImAw4mZiSMkeHP1pfI9Ok3o+HGeDB+xTtKKjcb5lMkm
 Zf+GDzRECfwIxCJX9XoHMt+2HgFCPBDNsASk/JQHxPDErBsyPepLR2BeoxwQpIxe/jZ9
 I0ZaFT6ayWyAp8BQszu/fNSXzyZeevFSBl2ix+UaAZCHjY1qG+NyogsoqmxPm8L/DiHv Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rh8gq0ag9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 11:01:50 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35TAucaK020413;
 Thu, 29 Jun 2023 11:01:49 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rh8gq0afe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 11:01:49 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35T8iMHc019951;
 Thu, 29 Jun 2023 11:01:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rdqre2fqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 11:01:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35TB1hxB19792502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 11:01:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D61AD2004B;
 Thu, 29 Jun 2023 11:01:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E73420043;
 Thu, 29 Jun 2023 11:01:43 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jun 2023 11:01:43 +0000 (GMT)
Date: Thu, 29 Jun 2023 13:01:42 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v3 1/7] s390-ccw: Getting rid of ulong
Message-ID: <20230629130142.3b22f508@p-imbrenda>
In-Reply-To: <20230629104821.194859-2-thuth@redhat.com>
References: <20230629104821.194859-1-thuth@redhat.com>
 <20230629104821.194859-2-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OQZKPmKi8ije0UV3QmDTAzDbdOzN2c_Y
X-Proofpoint-GUID: YW7jtHNhCNFIifJPLDepn35Fbc451pdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxlogscore=924
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290094
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 29 Jun 2023 12:48:15 +0200
Thomas Huth <thuth@redhat.com> wrote:

> From: Juan Quintela <quintela@redhat.com>
>=20
> Any good reason why this still exist?
> I can understand u* and __u* to be linux kernel like, but ulong?

shorter code? =C2=AF\_(=E3=83=84)_/=C2=AF

>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-Id: <20230510143925.4094-4-quintela@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/helper.h        |  2 +-
>  pc-bios/s390-ccw/s390-ccw.h      |  7 +++----
>  pc-bios/s390-ccw/virtio-scsi.h   |  2 +-
>  pc-bios/s390-ccw/virtio.h        |  4 ++--
>  pc-bios/s390-ccw/virtio-blkdev.c | 12 ++++++------
>  pc-bios/s390-ccw/virtio-scsi.c   |  4 ++--
>  pc-bios/s390-ccw/virtio.c        | 12 ++++++------
>  7 files changed, 21 insertions(+), 22 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
> index 3d0731c4c6..8e3dfcb6d6 100644
> --- a/pc-bios/s390-ccw/helper.h
> +++ b/pc-bios/s390-ccw/helper.h
> @@ -38,7 +38,7 @@ static inline void yield(void)
> =20
>  static inline void sleep(unsigned int seconds)
>  {
> -    ulong target =3D get_time_seconds() + seconds;
> +    unsigned long target =3D get_time_seconds() + seconds;
> =20
>      while (get_time_seconds() < target) {
>          yield();
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index b88e0550ab..f849fba74b 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -17,7 +17,6 @@ typedef unsigned char      u8;
>  typedef unsigned short     u16;
>  typedef unsigned int       u32;
>  typedef unsigned long long u64;
> -typedef unsigned long      ulong;
>  typedef unsigned char      __u8;
>  typedef unsigned short     __u16;
>  typedef unsigned int       __u32;
> @@ -67,11 +66,11 @@ void sclp_get_loadparm_ascii(char *loadparm);
>  int sclp_read(char *str, size_t count);
> =20
>  /* virtio.c */
> -unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
> -                                 ulong subchan_id, void *load_addr);
> +unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long =
rec_list2,
> +                                 unsigned long subchan_id, void *load_ad=
dr);
>  bool virtio_is_supported(SubChannelId schid);
>  int virtio_blk_setup_device(SubChannelId schid);
> -int virtio_read(ulong sector, void *load_addr);
> +int virtio_read(unsigned long sector, void *load_addr);
> =20
>  /* bootmap.c */
>  void zipl_load(void);
> diff --git a/pc-bios/s390-ccw/virtio-scsi.h b/pc-bios/s390-ccw/virtio-scs=
i.h
> index e6b6cd4815..c5612e16a2 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.h
> +++ b/pc-bios/s390-ccw/virtio-scsi.h
> @@ -68,7 +68,7 @@ static inline bool virtio_scsi_response_ok(const Virtio=
ScsiCmdResp *r)
>  }
> =20
>  int virtio_scsi_read_many(VDev *vdev,
> -                          ulong sector, void *load_addr, int sec_num);
> +                          unsigned long sector, void *load_addr, int sec=
_num);
>  int virtio_scsi_setup_device(SubChannelId schid);
> =20
>  #endif /* VIRTIO_SCSI_H */
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index e657d381ec..85bd9d1695 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -190,14 +190,14 @@ int virtio_get_block_size(void);
>  uint8_t virtio_get_heads(void);
>  uint8_t virtio_get_sectors(void);
>  uint64_t virtio_get_blocks(void);
> -int virtio_read_many(ulong sector, void *load_addr, int sec_num);
> +int virtio_read_many(unsigned long sector, void *load_addr, int sec_num);
> =20
>  #define VIRTIO_SECTOR_SIZE 512
>  #define VIRTIO_ISO_BLOCK_SIZE 2048
>  #define VIRTIO_SCSI_BLOCK_SIZE 512
>  #define VIRTIO_DASD_DEFAULT_BLOCK_SIZE 4096
> =20
> -static inline ulong virtio_sector_adjust(ulong sector)
> +static inline unsigned long virtio_sector_adjust(unsigned long sector)
>  {
>      return sector * (virtio_get_block_size() / VIRTIO_SECTOR_SIZE);
>  }
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-b=
lkdev.c
> index 794f99b42c..a81207b52e 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -16,7 +16,7 @@
>  #define VIRTIO_BLK_F_GEOMETRY   (1 << 4)
>  #define VIRTIO_BLK_F_BLK_SIZE   (1 << 6)
> =20
> -static int virtio_blk_read_many(VDev *vdev, ulong sector, void *load_add=
r,
> +static int virtio_blk_read_many(VDev *vdev, unsigned long sector, void *=
load_addr,
>                                  int sec_num)
>  {
>      VirtioBlkOuthdr out_hdr;
> @@ -49,7 +49,7 @@ static int virtio_blk_read_many(VDev *vdev, ulong secto=
r, void *load_addr,
>      return status;
>  }
> =20
> -int virtio_read_many(ulong sector, void *load_addr, int sec_num)
> +int virtio_read_many(unsigned long sector, void *load_addr, int sec_num)
>  {
>      VDev *vdev =3D virtio_get_device();
> =20
> @@ -63,14 +63,14 @@ int virtio_read_many(ulong sector, void *load_addr, i=
nt sec_num)
>      return -1;
>  }
> =20
> -unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
> -                                 ulong subchan_id, void *load_addr)
> +unsigned long virtio_load_direct(unsigned long rec_list1, unsigned long =
rec_list2,
> +                                 unsigned long subchan_id, void *load_ad=
dr)
>  {
>      u8 status;
>      int sec =3D rec_list1;
>      int sec_num =3D ((rec_list2 >> 32) & 0xffff) + 1;
>      int sec_len =3D rec_list2 >> 48;
> -    ulong addr =3D (ulong)load_addr;
> +    unsigned long addr =3D (unsigned long)load_addr;
> =20
>      if (sec_len !=3D virtio_get_block_size()) {
>          return -1;
> @@ -86,7 +86,7 @@ unsigned long virtio_load_direct(ulong rec_list1, ulong=
 rec_list2,
>      return addr;
>  }
> =20
> -int virtio_read(ulong sector, void *load_addr)
> +int virtio_read(unsigned long sector, void *load_addr)
>  {
>      return virtio_read_many(sector, load_addr, 1);
>  }
> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scs=
i.c
> index dcce696a33..d1a84b937c 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.c
> +++ b/pc-bios/s390-ccw/virtio-scsi.c
> @@ -150,7 +150,7 @@ static bool scsi_report_luns(VDev *vdev, void *data, =
uint32_t data_size)
>  }
> =20
>  static bool scsi_read_10(VDev *vdev,
> -                         ulong sector, int sectors, void *data,
> +                         unsigned long sector, int sectors, void *data,
>                           unsigned int data_size)
>  {
>      ScsiCdbRead10 cdb =3D {
> @@ -269,7 +269,7 @@ static int virtio_scsi_locate_device(VDev *vdev)
>  }
> =20
>  int virtio_scsi_read_many(VDev *vdev,
> -                          ulong sector, void *load_addr, int sec_num)
> +                          unsigned long sector, void *load_addr, int sec=
_num)
>  {
>      int sector_count;
>      int f =3D vdev->blk_factor;
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index f37510f312..5edd058d88 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -48,10 +48,10 @@ VirtioDevType virtio_get_device_type(void)
>  static long kvm_hypercall(unsigned long nr, unsigned long param1,
>                            unsigned long param2, unsigned long param3)
>  {
> -    register ulong r_nr asm("1") =3D nr;
> -    register ulong r_param1 asm("2") =3D param1;
> -    register ulong r_param2 asm("3") =3D param2;
> -    register ulong r_param3 asm("4") =3D param3;
> +    register unsigned long r_nr asm("1") =3D nr;
> +    register unsigned long r_param1 asm("2") =3D param1;
> +    register unsigned long r_param2 asm("3") =3D param2;
> +    register unsigned long r_param3 asm("4") =3D param3;
>      register long retval asm("2");
> =20
>      asm volatile ("diag %%r2,%%r4,0x500"
> @@ -145,7 +145,7 @@ void vring_send_buf(VRing *vr, void *p, int len, int =
flags)
>          vr->avail->ring[vr->avail->idx % vr->num] =3D vr->next_idx;
>      }
> =20
> -    vr->desc[vr->next_idx].addr =3D (ulong)p;
> +    vr->desc[vr->next_idx].addr =3D (unsigned long)p;
>      vr->desc[vr->next_idx].len =3D len;
>      vr->desc[vr->next_idx].flags =3D flags & ~VRING_HIDDEN_IS_CHAIN;
>      vr->desc[vr->next_idx].next =3D vr->next_idx;
> @@ -182,7 +182,7 @@ int vr_poll(VRing *vr)
>   */
>  int vring_wait_reply(void)
>  {
> -    ulong target_second =3D get_time_seconds() + vdev.wait_reply_timeout;
> +    unsigned long target_second =3D get_time_seconds() + vdev.wait_reply=
_timeout;
> =20
>      /* Wait for any queue to be updated by the host */
>      do {


